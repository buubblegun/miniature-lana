using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace miniature_lana
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            //miles was here
            AreaRegistration.RegisterAllAreas();
            RouteConfig.RegisterRoutes(RouteTable.Routes);
        }
    }
}
