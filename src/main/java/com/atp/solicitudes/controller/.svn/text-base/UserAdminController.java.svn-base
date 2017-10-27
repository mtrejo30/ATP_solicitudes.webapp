package com.atp.solicitudes.controller;

import java.text.MessageFormat;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.node.ArrayNode;
import org.codehaus.jackson.node.JsonNodeFactory;
import org.codehaus.jackson.node.ObjectNode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atp.solicitudes.manager.DomainManager;
import com.atp.solicitudes.model.Profile;
import com.atp.solicitudes.model.ReportAccessLevelEnum;
import com.atp.solicitudes.model.User;
import com.atp.solicitudes.model.UserStatusEnum;
import com.objectwave.dao.utils.DaoOrder;
import com.objectwave.dao.utils.DaoQuery;
import com.objectwave.dao.utils.DaoResult;
import com.objectwave.exception.DomainModelException;
import com.objectwave.session.SessionModelUser;
import com.objectwave.utils.JSONUtils;
import com.objectwave.webservice.model.ServerResponse;


@Controller
@RequestMapping ("user-admin")
public class UserAdminController extends LocalBaseController
{
	/**
	 * Field logger.
	 */
	protected static Logger logger = LoggerFactory.getLogger(UserAdminController.class);
	
	static String SEARCH_INFO_PARAM = "search_info";
	static int MAX_AUTOCOMPLETE_RESULTS = 10; // 0 = all results
	
	@Resource(name=DomainManager.BEAN_NAME)
	private DomainManager domainManager;

	@RequestMapping (method = RequestMethod.GET)
	public String show(Map<String, Object> model, HttpSession session)
	{
		try
		{
			// assigns ModelSession to model object
			setModelSession(session, model);
	
			// combo fields
			model.put("statusList", JSONUtils.getJSONFromObject(UserStatusEnum.getValidDisplayValues()));
			model.put("profileList", JSONUtils.getJSONFromObject(domainManager.getAllProfiles()));		
			model.put("empresaList", JSONUtils.getJSONFromObject(domainManager.getAllEmpresa()));
			model.put("reportAccessLevelList", JSONUtils.getJSONFromObject(ReportAccessLevelEnum.allValues));
	
			// return view name to be used
			return "user-admin";
		}
		catch (Exception ex)
		{
			String errorMsg = MessageFormat.format("error while rendering page", new Object[] {});
			logger.error(errorMsg, ex);

			model.put("errorMessage", errorMsg);
			return "error";
		}
	}

	@RequestMapping(value = "/user-admin-table-info", method = RequestMethod.GET)
	@ResponseBody
	public Object userAdminTableInfoRequest(HttpServletRequest request)
	{
		DaoQuery query = getTableQuery(request);
		DaoOrder order = getTableOrder(request);

		// Get users to be displayed on table
		DaoResult<User> users = getUsers(query, order);

		ObjectNode object = getTableMainNode(users);
		
		// Populate table
		ArrayNode rows = getUserNodes(users.getCollection());

		// set the rows property
		object.put("rows", rows);

		// return the object to the UI table
		return object;
	}

	private DaoQuery getTableQuery(HttpServletRequest request)
	{
		// map for query filters
		DaoQuery query = new DaoQuery();

		// request parameters that defines the page and number of rows to get
		Integer pageNumber = Integer.parseInt(request.getParameter(PAGE_PARAMETER));
		Integer numberOfRows = Integer.parseInt(request.getParameter(ROWS_PARAMETER));

		query.setPageNumber(pageNumber);
		query.setNumberOfRows(numberOfRows);
		query.setRequestTotalRows(true);

		try
		{
			JsonNode node = JSONUtils.getJSONFromString(request.getParameter(SEARCH_INFO_PARAM));
			//SearchUserForm searchUserForm = (SearchUserForm) JSONUtils.getObjectFromJSONString(request.getParameter(SearchUserForm.MODEL_NAME), SearchUserForm.class);

			// if no search info, return an empty query map
			if (node == null)
				return query;

			addStringParameterToQuery(query, node, "username", "username");
			addStringParameterToQuery(query, node, "email", "email");
			addObjectParameterToQuery(query, node, "status", "status", new UserStatusEnum.IdResolver());
			addObjectParameterToQuery(query, node, "profile", "profile", new Profile.IdResolver());
		}
		catch (Exception e)
		{
			String errorMsg = MessageFormat.format("error while processing query information", new Object[] {});
			logger.error(errorMsg, e);	
		}

		return query;
	}

	@RequestMapping(value = "/user-table-row", method = RequestMethod.POST)
	@ResponseBody
	public Object userTableRowRequest(@RequestBody JsonNode nodeQuery)
	{
		DaoQuery query = DaoQuery.withFilter("id", nodeQuery.get("id").asInt());
		DaoOrder order = new DaoOrder();

		DaoResult<User> col = getUsers(query, order);
		
		// collection to hold all the rows
		ArrayNode rows = getUserNodes(col.getCollection());
		
		ServerResponse response = new ServerResponse();
		
		response.setBody(rows.get(0));

		return response;
	}

	private DaoResult<User> getUsers(DaoQuery query, DaoOrder order)
	{
		DaoResult<User> users = null;

		// perform query
		try
		{
			users = domainManager.queryUser(query, order);
		}
		catch (Exception e)
		{
			String errorMsg = MessageFormat.format("Error_while_retrieving_users", new Object[] {});
			logger.error(getMessageFromResource(errorMsg), e);
		}

		return users;
	}

	private ArrayNode getUserNodes(List<User> users)
	{
		// collection to hold all the rows
		ArrayNode rows = new ArrayNode(JsonNodeFactory.instance);

		// loop through the resulting objects
		for (User eachUser : users)		
		{
			// object to hold each information row
			ObjectNode eachObject = new ObjectNode(JsonNodeFactory.instance);

			// sets the object id, required by the UI table
			eachObject.put("id", eachUser.getId());

			// array that will contain all columns information
			ArrayNode eachArray = new ArrayNode(JsonNodeFactory.instance);

			// column info
			eachArray.add(eachUser.getId());
			eachArray.add(eachUser.getUsername());
			eachArray.add(eachUser.getFirstName());
			eachArray.add(eachUser.getLastName());
			eachArray.add(eachUser.getProfile().getName());
			eachArray.add(eachUser.getStatus().getName());			
			eachArray.add(eachUser.getEmail());

			// set column info on the cell property
			eachObject.put("cell", eachArray);

			// add the object to the rows collection
			rows.add(eachObject);
		}

		return rows;
	}

	/*
	 * This method deletes the selected user
	 */
	@RequestMapping (value = "/delete-user", method = RequestMethod.POST)
	@ResponseBody
	public ServerResponse deleteUserRequest(@RequestBody ObjectNode obj, HttpSession session)
	{
		ServerResponse response = new ServerResponse();

		//get the id of the user to delete
		Integer id = obj.get("id").asInt();

		User user = null;

		try
		{
			user = domainManager.getUserWithId(id);
		}
		catch (Exception e) 
		{
			String errorMsg = getMessageFromResource("Error_while_getting_user");
			response.setError(true);

			response.setMessage(errorMsg);
			return response;
		}

		// ensure we do not delete the logged user
		SessionModelUser loggedUser = getSessionModel(session).getLoggedUser();
		
		if (loggedUser.equals(user))
		{
			response.setError(true);
			response.setMessage(getMessageFromResource("Cannot_delete_logged_user"));
			return response;
		}
		
		try
		{
			domainManager.deleteUser(user);
		}
		catch (Exception e)
		{
			response.setError(true);
			response.setMessage(e.getMessage());
			return response;
		}

		response.setMessage("User_deleted");
		return response;
	}

	/*
	 * This method updates or creates a new user.
	 */
	@RequestMapping (value = "/save-user", method = RequestMethod.POST)
	@ResponseBody
	public ServerResponse saveUserRequest(@RequestBody JsonNode node)
	{
		ServerResponse response = new ServerResponse();

		try
		{
			User user = domainManager.processSaveUpdateUser(node);
			
			ObjectNode bodyNode = new ObjectNode(JsonNodeFactory.instance);
			bodyNode.put("id", user.getId());

			response.setBody(bodyNode);
			response.setMessage(getMessageFromResource("User_saved"));
		}
		catch (DomainModelException dme)
		{
			String msg = getMessageFromResource(dme.getMessage());

			logger.error(msg, dme);
			response.setError(true);
			response.setMessage(msg);
		}
		catch (Exception ex)
		{
			String msg = getMessageFromResource("Error_while_saving_user");

			logger.error(msg, ex);
			response.setError(true);
			response.setMessage(msg );
		}

		return response;
	}
	
	@RequestMapping(value = "/edit-user", method = RequestMethod.POST)
	public @ResponseBody Object editUserRequest(@RequestBody JsonNode obj)
	{			
		ServerResponse response = new ServerResponse();

		//get the id of the user to edit
		Integer id = obj.get("id").asInt();

		//get the user
		User user = null;
		try
		{
			user = domainManager.getUserWithId(id);
			user.clearPassword();
		}
		catch (Exception e)
		{
			// Something was wrong while doing the search
			String msg = "Error while executing query";
			response.setError(true);
			response.setMessage(msg + " - " + e);
			return response;
		}
		
		response.setBody(user);
		
		return response;
	}
	
	@RequestMapping(value = "/get-user-names", method = RequestMethod.GET)
	@ResponseBody
	public Object getUserNamesRequest(@RequestParam("term") String queryPattern) throws Exception
	{
		return getColumnValues("username", queryPattern);
	}
	
	@RequestMapping(value = "/get-user-emails", method = RequestMethod.GET)
	@ResponseBody
	public Object getUserEmailsRequest(@RequestParam("term") String queryPattern) throws Exception
	{
		return getColumnValues("email", queryPattern);
	}

	public Object getColumnValues(String columnName, String patternValue) throws Exception
	{		
		List<String> values = Collections.emptyList();
		
		try
		{
			values = domainManager.getUsersColumnPropertyValues(columnName, "%" + patternValue.trim() + "%", MAX_AUTOCOMPLETE_RESULTS);
		}
		catch (Exception ex)
		{
			logger.error("error while getting column values", ex);
		}

		return values;					
	}
}