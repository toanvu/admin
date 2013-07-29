package de.edunet24.home;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Properties;

import javax.ejb.EJBAccessException;
import javax.naming.Context;
import javax.naming.InitialContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import de.edunet24.usermanager.dev.entityBeans.Permission;
import de.edunet24.usermanager.dev.entityBeans.Role;
import de.edunet24.usermanager.dev.entityBeans.Service;
import de.edunet24.usermanager.dev.entityBeans.ServicePermission;
import de.edunet24.usermanager.dev.entityBeans.User;
import de.edunet24.usermanager.dev.entityInterfaces.IUserManager;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory
			.getLogger(HomeController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		//this.generateData();
		init(locale, model);			
		return "home";
	}
	
	/**
	 * prepare common values/parameters
	 * @param locale
	 * @param model
	 */
	public void init(Locale locale, Model model){
		try {
			
			IUserManager manager = this.getUserManagementBean();
			
			List<User> allUser = manager.getAllUser();			
			model.addAttribute("users",allUser);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
		}
	}
	
	/**
	 * get UsermanagerBean
	 * @return Bean
	 * @throws Exception
	 */
	public IUserManager getUserManagementBean() throws Exception{
		Properties props = new Properties();
		props.put(Context.URL_PKG_PREFIXES, "org.jboss.ejb.client.naming");
		
		Context context = new InitialContext(props);

		IUserManager manager = (IUserManager) context
				.lookup("ejb:/commonejb//UserManager!de.edunet24.usermanager.dev.entityInterfaces.IUserManager");
		return manager;
	}
	
	/**
	 * update user
	 * @param locale
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/update/user", method = RequestMethod.POST)
	public String updateUser(
			@RequestParam(value="id") int id,
			@RequestParam(value="username") String username,
			@RequestParam(value="password") String password,
			@RequestParam(value="firstname") String firstname,
			@RequestParam(value="lastname") String lastname,
			@RequestParam(value="gender") String gender,
			@RequestParam(value="email") String email,
			@RequestParam(value="refId") Long refId,			
			Locale locale, Model model) {

		Date modifiedDate= new Date();
		try {
			IUserManager manager = this.getUserManagementBean();
			User user = manager.getUser(id);
			user.setUsername(username);
			user.setPassword(password);
			user.setFirstname(firstname);
			user.setLastname(lastname);
			user.setGender(gender);
			user.setEmail(email);
			user.setSchoolId(refId);
			user.setUpdatedDate(modifiedDate);
			manager.updateUser(user,null);
		} catch (EJBAccessException e) {
			return "authorizationerror";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		init(locale, model);
		model.addAttribute("tab", "user");
		return "redirect:/";
	}
	
	/**
	 * generate some default datas
	 */
	public void generateData(){
		try{
			IUserManager manager = this.getUserManagementBean();
			
					
			Service service1 = manager.createService("usermanagement-module");
			
			Permission p0 = manager.createPermission("none");
			Permission p1 = manager.createPermission("read");
			Permission p2 = manager.createPermission("write");
			Permission p3 = manager.createPermission("exe");
			
			ServicePermission sp0 = manager.createServicePermission(service1, p0);
			ServicePermission sp1 = manager.createServicePermission(service1, p1);
			ServicePermission sp2 = manager.createServicePermission(service1, p2);
			ServicePermission sp3 = manager.createServicePermission(service1, p3);
			
			Role normalUser = manager.createRole("normal user", sp0);
			Role schoolManager = manager.createRole("school admin", sp3);
			
						
			User user = manager.createUser("12345", "noface");
			
			user.setRole(normalUser);			
			
			user = manager.addUser(user);
		
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	/**
	 * add user
	 * @param locale
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/add/user", method = RequestMethod.POST)
	public String addUser(	
			@RequestParam(value="username") String username,
			@RequestParam(value="password") String password,
			@RequestParam(value="firstname") String firstname,
			@RequestParam(value="lastname") String lastname,
			@RequestParam(value="gender") String gender,
			@RequestParam(value="email") String email,
			
			Locale locale, Model model) {		
		
		Date createDate= new Date();
		try {
			logger.info("add new user -------------------------------------");
			IUserManager manager = this.getUserManagementBean();
			User user = manager.createUser(password, username);
			user.setUsername(username);
			user.setPassword(password);
			user.setFirstname(firstname);
			user.setLastname(lastname);
			user.setGender(gender);
			user.setEmail(email);
//			user.setSchoolId(refId);
			user.setUpdatedDate(createDate);
			user.setCreatedDate(createDate);
			manager.addUser(user);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		init(locale, model);
		return "redirect:/";
	}
	
	/**
	 * update role
	 * @param locale
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/update/role", method = RequestMethod.GET)
	public String updateRole(Locale locale, Model model) {
		init(locale, model);
		return "home";
	}
	
	/**
	 * update user
	 * @param locale
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/add/role", method = RequestMethod.GET)
	public String addRole(Locale locale, Model model) {
		init(locale, model);
		return "home";
	}
	
	/**
	 * update service
	 * @param locale
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/update/service", method = RequestMethod.GET)
	public String updateService(Locale locale, Model model) {
		init(locale, model);
		return "home";
	}
	
	/**
	 * add service
	 * @param locale
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/add/service", method = RequestMethod.GET)
	public String addService(Locale locale, Model model) {
		init(locale, model);
		return "home";
	}
}
