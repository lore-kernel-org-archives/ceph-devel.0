From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Sun, 13 Mar 2016 10:40:37 -0700
Message-ID: <56e5a61561b13_11afabd3309442f@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.37.59]:60329 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534AbcCMRkm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 13 Mar 2016 13:40:42 -0400
Received: from localhost.localdomain (static-208.69.177.245.nephosdns.com [208.69.177.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtprelay.synopsys.com (Postfix) with ESMTPS id 3055B1E05BA
	for <ceph-devel@vger.kernel.org>; Sun, 13 Mar 2016 18:40:38 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

6 new defect(s) introduced to ceph found with Coverity Scan.


New defect(s) Reported-by: Coverity Scan
Showing 6 of 6 defect(s)


** CID 1352184:  Uninitialized members  (UNINIT_CTOR)
/rgw/rgw_lib.h: 35 in rgw::RGWLib::RGWLib()()


________________________________________________________________________________________________________
*** CID 1352184:  Uninitialized members  (UNINIT_CTOR)
/rgw/rgw_lib.h: 35 in rgw::RGWLib::RGWLib()()
29         rgw::LDAPHelper* ldh;
30         RGWREST rest; // XXX needed for RGWProcessEnv
31         RGWRados* store;
32     
33       public:
34         RGWLib() : fec(nullptr), fe(nullptr), olog(nullptr), store(nullptr)
>>>     CID 1352184:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "ldh" is not initialized in this constructor nor in any functions that it calls.
35           {}
36         ~RGWLib() {}
37     
38         RGWRados* get_store() { return store; }
39     
40         RGWLibFrontend* get_fe() { return fe; }

** CID 1355599:  Error handling issues  (CHECKED_RETURN)
/rgw/rgw_token.h: 89 in rgw::RGWToken::RGWToken(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&)()


________________________________________________________________________________________________________
*** CID 1355599:  Error handling issues  (CHECKED_RETURN)
/rgw/rgw_token.h: 89 in rgw::RGWToken::RGWToken(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&)()
83         RGWToken(enum token_type _type, const std::string& _id,
84     	     const std::string& _key)
85           : type(_type), id(_id), key(_key) {};
86     
87         RGWToken(const string& json) {
88           JSONParser p;
>>>     CID 1355599:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "parse" without checking return value (as is done elsewhere 35 out of 36 times).
89           p.parse(json.c_str(), json.length());
90           JSONDecoder::decode_json(RGWToken::type_name, *this, &p);
91         }
92     
93         void encode(bufferlist& bl) const {
94           uint32_t ver = version();

** CID 1355600:  Error handling issues  (UNCAUGHT_EXCEPT)
/rgw/rgw_token.cc: 60 in main()


________________________________________________________________________________________________________
*** CID 1355600:  Error handling issues  (UNCAUGHT_EXCEPT)
/rgw/rgw_token.cc: 60 in main()
54            << std::endl;
55       cout << "\t <token type> := ad | ldap" << std::endl;
56       cout << "\n";
57       generic_client_usage();
58     }
59     
>>>     CID 1355600:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "JSONDecoder::err" is thrown and never caught.
60     int main(int argc, char **argv)
61     {
62       std::string val;
63       vector<const char*> args;
64       argv_to_vec(argc, (const char **)argv, args);
65       env_to_vec(args);

** CID 1355601:  Error handling issues  (UNCAUGHT_EXCEPT)
/rgw/rgw_token.cc: 60 in main()


________________________________________________________________________________________________________
*** CID 1355601:  Error handling issues  (UNCAUGHT_EXCEPT)
/rgw/rgw_token.cc: 60 in main()
54            << std::endl;
55       cout << "\t <token type> := ad | ldap" << std::endl;
56       cout << "\n";
57       generic_client_usage();
58     }
59     
>>>     CID 1355601:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::bad_get" is thrown and never caught.
60     int main(int argc, char **argv)
61     {
62       std::string val;
63       vector<const char*> args;
64       argv_to_vec(argc, (const char **)argv, args);
65       env_to_vec(args);

** CID 1355602:    (UNCAUGHT_EXCEPT)
/rgw/rgw_token.cc: 60 in main()
/rgw/rgw_token.cc: 60 in main()


________________________________________________________________________________________________________
*** CID 1355602:    (UNCAUGHT_EXCEPT)
/rgw/rgw_token.cc: 60 in main()
54            << std::endl;
55       cout << "\t <token type> := ad | ldap" << std::endl;
56       cout << "\n";
57       generic_client_usage();
58     }
59     
>>>     CID 1355602:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
60     int main(int argc, char **argv)
61     {
62       std::string val;
63       vector<const char*> args;
64       argv_to_vec(argc, (const char **)argv, args);
65       env_to_vec(args);
/rgw/rgw_token.cc: 60 in main()
54            << std::endl;
55       cout << "\t <token type> := ad | ldap" << std::endl;
56       cout << "\n";
57       generic_client_usage();
58     }
59     
>>>     CID 1355602:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<std::ios_base::failure> >" is thrown and never caught.
60     int main(int argc, char **argv)
61     {
62       std::string val;
63       vector<const char*> args;
64       argv_to_vec(argc, (const char **)argv, args);
65       env_to_vec(args);

** CID 1355603:  Control flow issues  (UNREACHABLE)
/rgw/rgw_token.h: 65 in rgw::RGWToken::from_type(rgw::RGWToken::token_type)()


________________________________________________________________________________________________________
*** CID 1355603:  Control flow issues  (UNREACHABLE)
/rgw/rgw_token.h: 65 in rgw::RGWToken::from_type(rgw::RGWToken::token_type)()
59           case TOKEN_KEYSTONE:
60     	return "keystone";
61     	break;
62           default:
63     	return "none";
64           };
>>>     CID 1355603:  Control flow issues  (UNREACHABLE)
>>>     This code cannot be reached: "return "none";".
65           return "none";
66         }
67     
68         token_type type;
69         string id;
70         string key;


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://scan.coverity.com/projects/ceph?tab=overview

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://scan.coverity.com/subscriptions/edit?email=ceph-devel%40vger.kernel.org&token=018084d671e3cc89d00dd2ccb7eb849c

