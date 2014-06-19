From: Benny Kopilov <bkopilov@redhat.com>
Subject: unable to create volume with openstack rhos 5  -
 cinder.api.middleware.fault
Date: Thu, 19 Jun 2014 04:06:54 -0400 (EDT)
Message-ID: <425147976.16474794.1403165214735.JavaMail.zimbra@redhat.com>
References: <640514811.16029637.1403095540996.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:47270 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757336AbaFSIGz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jun 2014 04:06:55 -0400
Received: from zmail23.collab.prod.int.phx2.redhat.com (zmail23.collab.prod.int.phx2.redhat.com [10.5.83.28])
	by mx6-phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s5J86spN024583
	for <ceph-devel@vger.kernel.org>; Thu, 19 Jun 2014 04:06:54 -0400
In-Reply-To: <640514811.16029637.1403095540996.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi , 

I am trying for the first time to use ceph as backend , for glance and cinder .
I installed openstack with ceph as backend for glance and cinder .

When i add new volume ( without image attached ) - it works
When i create new instance and attach  volume to it - works  
When i create volume from image - it Fails 

Can u please explain what's wrong ? 

My ceph info :
 ceph version 0.80.1 (a38fe1169b6d2ac98b427334c12d7cf81f809b74)

From the log file : 

63 2014-06-19 10:47:08.517 7200 DEBUG glanceclient.common.http [req-a51a1416-00d6-45a2-9317-e5c7a584907f 2cc83395e9d546a3b7344bae7d7c886d 5946a38bd52e4b719c65bf8448d0032e - - -] curl -i -X GET -H 'X-Auth-Token:     8805a995bab670ad568d328e6af48ff0' -H 'Content-Type: application/json' -H 'User-Agent: python-glanceclient' http://10.35.3.109:9292/v2/schemas/image log_curl_request /usr/lib/python2.7/site-packages/glancecl    ient/common/http.py:142
164 2014-06-19 10:47:08.532 7200 DEBUG glanceclient.common.http [req-a51a1416-00d6-45a2-9317-e5c7a584907f 2cc83395e9d546a3b7344bae7d7c886d 5946a38bd52e4b719c65bf8448d0032e - - -]
165 HTTP/1.1 200 OK
166 date: Thu, 19 Jun 2014 07:47:08 GMT
167 content-length: 3677
168 content-type: application/json; charset=UTF-8
169 x-openstack-request-id: req-7ca53a3f-7200-4d94-a49d-36bf55148e6a
170 
171 {"additionalProperties": {"type": "string"}, "name": "image", "links": [{"href": "{self}", "rel": "self"}, {"href": "{file}", "rel": "enclosure"}, {"href": "{schema}", "rel": "describedby"}], "properties": {    "status": {"enum": ["queued", "saving", "active", "killed", "deleted", "pending_delete"], "type": "string", "description": "Status of the image (READ-ONLY)"}, "tags": {"items": {"type": "string", "maxLength"    : 255}, "type": "array", "description": "List of strings related to the image"}, "kernel_id": {"pattern": "^([0-9a-fA-F]){8}-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){12}$", "type": "s    tring", "description": "ID of image stored in Glance that should be used as the kernel when booting an AMI-style image."}, "container_format": {"enum": ["ami", "ar
 i", "aki", "bare", "ovf", "ova"], "type": "s    tring", "description": "Format of the container"}, "min_ram": {"type": "integer", "description": "Amount of ram (in MB) required to boot image."}, "ramdisk_id": {"pattern": "^([0-9a-fA-F]){8}-([0-9a-fA-F]){4    }-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){12}$", "type": "string", "description": "ID of image stored in Glance that should be used as the ramdisk when booting an AMI-style image."}, "locations": {"i    tems": {"required": ["url", "metadata"], "type": "object", "properties": {"url": {"type": "string", "maxLength": 255}, "metadata": {"type": "object"}}}, "type": "array", "description": "A set of URLs to acce    ss the image file kept in external store"}, "visibility": {"enum": ["public", "private"], "type": "string", "descript
 ion": "Scope of image accessibility"}, "updated_at": {"type": "string", "description": "Da    te and time of the last image modification (READ-ONLY)"}, "owner": {"type": "string", "description": "Owner of the image", "maxLength": 255}, "file": {"type": "string", "description": "(READ-ONLY)"}, "min_di    sk": {"type": "integer", "description": "Amount of disk space (in GB) required to boot image."}, "virtual_size": {"type": "integer", "description": "Virtual size of image in bytes (READ-ONLY)"}, "id": {"patt    ern": "^([0-9a-fA-F]){8}-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){12}$", "type": "string", "description": "An identifier for the image"}, "size": {"type": "integer", "description": "S    ize of image file in bytes (READ-ONLY)"}, "instance_uuid": {"type": "st
 ring", "description": "ID of instance used to create this image."}, "os_distro": {"type": "string", "description": "Common name of opera    ting system distribution as specified in http://docs.openstack.org/trunk/openstack-compute/admin/content/adding-images.html"}, "name": {"type": "string", "description": "Descriptive name for the image", "max    Length": 255}, "checksum": {"type": "string", "description": "md5 hash of image contents. (READ-ONLY)", "maxLength": 32}, "created_at": {"type": "string", "description": "Date and time of image registration     (READ-ONLY)"}, "disk_format": {"enum": ["ami", "ari", "aki", "vhd", "vmdk", "raw", "qcow2", "vdi", "iso"], "type": "string", "description": "Format of the disk"}, "os_version": {"type": "string", "descriptio    n": "Operating system ver
 sion as specified by the distributor"}, "protected": {"type": "boolean", "description": "If true, image will not be deletable."}, "architecture": {"type": "string", "description": "O    perating system architecture as specified in http://docs.openstack.org/trunk/openstack-compute/admin/content/adding-images.html"}, "direct_url": {"type": "string", "description": "URL to access the image fil    e kept in external store (READ-ONLY)"}, "self": {"type": "string", "description": "(READ-ONLY)"}, "schema": {"type": "string", "description": "(READ-ONLY)"}}}
172  log_http_response /usr/lib/python2.7/site-packages/glanceclient/common/http.py:152
173 2014-06-19 10:47:08.534 7200 DEBUG glanceclient.common.http [req-a51a1416-00d6-45a2-9317-e5c7a584907f 2cc83395e9d546a3b7344bae7d7c886d 5946a38bd52e4b719c65bf8448d0032e - - -] curl -i -X GET -H 'X-Auth-Token:     8805a995bab670ad568d328e6af48ff0' -H 'Content-Type: application/json' -H 'User-Agent: python-glanceclient' http://10.35.3.109:9292/v2/schemas/member log_curl_request /usr/lib/python2.7/site-packages/glancec    lient/common/http.py:142
174 2014-06-19 10:47:08.538 7200 DEBUG glanceclient.common.http [req-a51a1416-00d6-45a2-9317-e5c7a584907f 2cc83395e9d546a3b7344bae7d7c886d 5946a38bd52e4b719c65bf8448d0032e - - -]
175 HTTP/1.1 200 OK
176 date: Thu, 19 Jun 2014 07:47:08 GMT
177 content-length: 660
178 content-type: application/json; charset=UTF-8
179 x-openstack-request-id: req-a6ee2306-4ca4-4f8e-a464-49f8fcf1d3b3
180 
181 {"name": "member", "properties": {"status": {"enum": ["pending", "accepted", "rejected"], "type": "string", "description": "The status of this image member"}, "created_at": {"type": "string", "description":     "Date and time of image member creation"}, "updated_at": {"type": "string", "description": "Date and time of last modification of image member"}, "image_id": {"pattern": "^([0-9a-fA-F]){8}-([0-9a-fA-F]){4}-(    [0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){12}$", "type": "string", "description": "An identifier for the image"}, "member_id": {"type": "string", "description": "An identifier for the image member (tena    ntId)"}, "schema": {"type": "string"}}}
182  log_http_response /usr/lib/python2.7/site-packages/glanceclient/common/http.py:152
183 2014-06-19 10:47:08.538 7200 DEBUG glanceclient.common.http [req-a51a1416-00d6-45a2-9317-e5c7a584907f 2cc83395e9d546a3b7344bae7d7c886d 5946a38bd52e4b719c65bf8448d0032e - - -] curl -i -X GET -H 'X-Auth-Token:     8805a995bab670ad568d328e6af48ff0' -H 'Content-Type: application/json' -H 'User-Agent: python-glanceclient' http://10.35.3.109:9292/v2/images/24d8ac36-d730-4acf-9145-b940432b8efe log_curl_request /usr/lib/py    thon2.7/site-packages/glanceclient/common/http.py:142
184 2014-06-19 10:47:08.550 7200 DEBUG glanceclient.common.http [req-a51a1416-00d6-45a2-9317-e5c7a584907f 2cc83395e9d546a3b7344bae7d7c886d 5946a38bd52e4b719c65bf8448d0032e - - -]
185 HTTP/1.1 200 OK
186 date: Thu, 19 Jun 2014 07:47:08 GMT
187 content-length: 715
188 content-type: application/json; charset=UTF-8
189 x-openstack-request-id: req-45020d63-0d4c-4b34-976e-88cf864cefb6
190 
191 {"status": "active", "schema": "/v2/schemas/image", "description": "test_image_ceph", "tags": [], "container_format": "bare", "created_at": "2014-06-19T07:40:47Z", "size": 13147648, "disk_format": "qcow2", "    updated_at": "2014-06-19T07:40:49Z", "visibility": "private", "self": "/v2/images/24d8ac36-d730-4acf-9145-b940432b8efe", "min_disk": 0, "protected": false, "id": "24d8ac36-d730-4acf-9145-b940432b8efe", "file    ": "/v2/images/24d8ac36-d730-4acf-9145-b940432b8efe/file", "checksum": "d972013792949d0d3ba628fbe8685bce", "owner": "5946a38bd52e4b719c65bf8448d0032e", "direct_url": "rbd://1e67fb7f-4c56-44ec-a6c7-2a84ab7c2a    d4/images/24d8ac36-d730-4acf-9145-b940432b8efe/snap", "min_ram": 0, "name": "test_image_ceph"}
192  log_http_response /usr/lib/python2.7/site-packages/glanceclient/common/http.py:152
193 2014-06-19 10:47:08.558 7200 ERROR cinder.api.middleware.fault [req-a51a1416-00d6-45a2-9317-e5c7a584907f 2cc83395e9d546a3b7344bae7d7c886d 5946a38bd52e4b719c65bf8448d0032e - - -] Caught error: deleted
194 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault Traceback (most recent call last):
195 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/cinder/api/middleware/fault.py", line 75, in __call__
196 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     return req.get_response(self.application)
197 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/webob/request.py", line 1296, in send
198 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     application, catch_exc_info=False)
199 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/webob/request.py", line 1260, in call_application
200 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     app_iter = application(self.environ, start_response)
201 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/webob/dec.py", line 144, in __call__
202 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     return resp(environ, start_response)
203 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/keystoneclient/middleware/auth_token.py", line 615, in __call__
204 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     return self.app(env, start_response)
205 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/webob/dec.py", line 144, in __call__
206 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     return resp(environ, start_response)
207 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/webob/dec.py", line 144, in __call__
208 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     return resp(environ, start_response)
209 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/routes/middleware.py", line 131, in __call__
210 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     response = self.app(environ, start_response)
211 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/webob/dec.py", line 144, in __call__
212 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     return resp(environ, start_response)
213 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/webob/dec.py", line 130, in __call__
214 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     resp = self.call_func(req, *args, **self.kwargs)
215 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/webob/dec.py", line 195, in call_func
216 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     return self.func(req, *args, **kwargs)
217 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/cinder/api/openstack/wsgi.py", line 895, in __call__
218 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     content_type, body, accept)
219 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/cinder/api/openstack/wsgi.py", line 943, in _process_stack
220 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     action_result = self.dispatch(meth, request, action_args)
221 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/cinder/api/openstack/wsgi.py", line 1019, in dispatch
222 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     return method(req=request, **action_args)
223 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/cinder/api/v1/volumes.py", line 432, in create
224 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     **kwargs)
225 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/cinder/volume/api.py", line 189, in create
226 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     flow_engine.run()
227 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/taskflow/utils/lock_utils.py", line 51, in wrapper
228 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     return f(*args, **kwargs)
229 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/taskflow/engines/action_engine/engine.py", line 118, in run
230 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     self._run()
231 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/taskflow/engines/action_engine/engine.py", line 128, in _run
232 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     self._revert(misc.Failure())
233 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/taskflow/engines/action_engine/engine.py", line 81, in _revert
234 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     misc.Failure.reraise_if_any(failures.values())
235 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/taskflow/utils/misc.py", line 487, in reraise_if_any
184 2014-06-19 10:47:08.550 7200 DEBUG glanceclient.common.http [req-a51a1416-00d6-45a2-9317-e5c7a584907f 2cc83395e9d546a3b7344bae7d7c886d 5946a38bd52e4b719c65bf8448d0032e - - -]
185 HTTP/1.1 200 OK
186 date: Thu, 19 Jun 2014 07:47:08 GMT
187 content-length: 715
188 content-type: application/json; charset=UTF-8
189 x-openstack-request-id: req-45020d63-0d4c-4b34-976e-88cf864cefb6
190 
191 {"status": "active", "schema": "/v2/schemas/image", "description": "test_image_ceph", "tags": [], "container_format": "bare", "created_at": "2014-06-19T07:40:47Z", "size": 13147648, "disk_format": "qcow2", "    updated_at": "2014-06-19T07:40:49Z", "visibility": "private", "self": "/v2/images/24d8ac36-d730-4acf-9145-b940432b8efe", "min_disk": 0, "protected": false, "id": "24d8ac36-d730-4acf-9145-b940432b8efe", "file    ": "/v2/images/24d8ac36-d730-4acf-9145-b940432b8efe/file", "checksum": "d972013792949d0d3ba628fbe8685bce", "owner": "5946a38bd52e4b719c65bf8448d0032e", "direct_url": "rbd://1e67fb7f-4c56-44ec-a6c7-2a84ab7c2a    d4/images/24d8ac36-d730-4acf-9145-b940432b8efe/snap", "min_ram": 0, "name": "test_image_ceph"}
192  log_http_response /usr/lib/python2.7/site-packages/glanceclient/common/http.py:152
193 2014-06-19 10:47:08.558 7200 ERROR cinder.api.middleware.fault [req-a51a1416-00d6-45a2-9317-e5c7a584907f 2cc83395e9d546a3b7344bae7d7c886d 5946a38bd52e4b719c65bf8448d0032e - - -] Caught error: deleted
194 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault Traceback (most recent call last):
195 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/cinder/api/middleware/fault.py", line 75, in __call__
196 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     return req.get_response(self.application)
197 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/webob/request.py", line 1296, in send
198 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     application, catch_exc_info=False)
199 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/webob/request.py", line 1260, in call_application
200 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     app_iter = application(self.environ, start_response)
201 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/webob/dec.py", line 144, in __call__
202 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     return resp(environ, start_response)
203 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/keystoneclient/middleware/auth_token.py", line 615, in __call__
204 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     return self.app(env, start_response)
205 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/webob/dec.py", line 144, in __call__
206 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     return resp(environ, start_response)
207 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/webob/dec.py", line 144, in __call__
208 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     return resp(environ, start_response)
209 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/routes/middleware.py", line 131, in __call__
210 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     response = self.app(environ, start_response)
211 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/webob/dec.py", line 144, in __call__
212 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     return resp(environ, start_response)
213 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/webob/dec.py", line 130, in __call__
214 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     resp = self.call_func(req, *args, **self.kwargs)
215 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/webob/dec.py", line 195, in call_func
216 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     return self.func(req, *args, **kwargs)
217 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/cinder/api/openstack/wsgi.py", line 895, in __call__
218 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     content_type, body, accept)
219 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/cinder/api/openstack/wsgi.py", line 943, in _process_stack
220 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     action_result = self.dispatch(meth, request, action_args)
221 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/cinder/api/openstack/wsgi.py", line 1019, in dispatch
222 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     return method(req=request, **action_args)
223 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/cinder/api/v1/volumes.py", line 432, in create
224 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     **kwargs)
225 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/cinder/volume/api.py", line 189, in create
226 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     flow_engine.run()
227 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/taskflow/utils/lock_utils.py", line 51, in wrapper
228 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     return f(*args, **kwargs)
229 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/taskflow/engines/action_engine/engine.py", line 118, in run
230 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     self._run()
231 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/taskflow/engines/action_engine/engine.py", line 128, in _run
232 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     self._revert(misc.Failure())
233 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/taskflow/engines/action_engine/engine.py", line 81, in _revert
234 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     misc.Failure.reraise_if_any(failures.values())
235 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/taskflow/utils/misc.py", line 487, in reraise_if_any
236 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     failures[0].reraise()
237 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/taskflow/utils/misc.py", line 494, in reraise
238 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     six.reraise(*self._exc_info)
239 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/taskflow/engines/action_engine/executor.py", line 36, in _execute_task
240 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     result = task.execute(**arguments)
241 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/cinder/volume/flows/api/create_volume.py", line 341, in execute
242 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     self._check_image_metadata(context, image_id, size)
243 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/cinder/volume/flows/api/create_volume.py", line 180, in _check_image_metadata
244 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     image_meta = self.image_service.show(context, image_id)
245 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/cinder/image/glance.py", line 228, in show
246 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     base_image_meta = self._translate_from_glance(image)
247 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/cinder/image/glance.py", line 336, in _translate_from_glance
248 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     image_meta = _extract_attributes(image)
249 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/cinder/image/glance.py", line 434, in _extract_attributes
250 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     output[attr] = getattr(image, attr)
251 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault   File "/usr/lib/python2.7/site-packages/warlock/model.py", line 69, in __getattr__
252 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault     raise AttributeError(key)
253 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault AttributeError: deleted
254 2014-06-19 10:47:08.558 7200 TRACE cinder.api.middleware.fault
255 2014-06-19 10:47:08.559 7200 INFO cinder.api.middleware.fault [req-a51a1416-00d6-45a2-9317-e5c7a584907f 2cc83395e9d546a3b7344bae7d7c886d 5946a38bd52e4b719c65bf8448d0032e - - -] http://10.35.3.109:8776/v1/594    6a38bd52e4b719c65bf8448d0032e/volumes returned with HTTP 500
256 2014-06-19 10:47:08.560 7200 INFO eventlet.wsgi.server [req-a51a1416-00d6-45a2-9317-e5c7a584907f 2cc83395e9d546a3b7344bae7d7c886d 5946a38bd52e4b719c65bf8448d0032e - - -] 10.35.3.109 - - [19/Jun/2014 10:47:08    ] "POST /v1/5946a38bd52e4b719c65bf8448d0032e/volumes HTTP/1.1" 500 401 0.067066
257 2014-06-19 10:47:08.573 7200 INFO eventlet.wsgi.server [-] (7200) accepted ('10.35.3.109', 46257)
258 2014-06-19 10:47:08.574 7200 DEBUG keystoneclient.middleware.auth_token [-] Authenticating user token __call__ /usr/lib/python2.7/site-packages/keystoneclient/middleware/auth_token.py:602
259 2014-06-19 10:47:08.574 7200 DEBUG keystoneclient.middleware.auth_token [-] Removing headers from request environment: X-Identity-Status,X-Domain-Id,X-Domain-Name,X-Project-Id,X-Project-Name,X-Project-Domain    -Id,X-Project-Domain-Name,X-User-Id,X-User-Name,X-User-Domain-Id,X-User-Domain-Name,X-Roles,X-Service-Catalog,X-User,X-Tenant-Id,X-Tenant-Name,X-Tenant,X-Role _remove_auth_headers /usr/lib/python2.7/site-pac    kages/keystoneclient/middleware/auth_token.py:661
260 2014-06-19 10:47:08.574 7200 DEBUG keystoneclient.middleware.auth_token [-] Returning cached token _cache_get /usr/lib/python2.7/site-packages/keystoneclient/middleware/auth_token.py:1010
261 2014-06-19 10:47:08.575 7200 DEBUG keystoneclient.middleware.auth_token [-] Received request from user: 2cc83395e9d546a3b7344bae7d7c886d with project_id : 5946a38bd52e4b719c65bf8448d0032e and roles: SwiftOpe    rator,admin  _build_user_headers /usr/lib/python2.7/site-packages/keystoneclient/middleware/auth_token.py:909
262 2014-06-19 10:47:08.575 7200 DEBUG routes.middleware [req-57998d77-27ad-4108-9773-f98e57b490f2 2cc83395e9d546a3b7344bae7d7c886d 5946a38bd52e4b719c65bf8448d0032e - - -] Matched GET /5946a38bd52e4b719c65bf8448    d0032e/limits __call__ /usr/lib/python2.7/site-packages/routes/middleware.py:100
263 2014-06-19 10:47:08.576 7200 DEBUG routes.middleware [req-57998d77-27ad-4108-9773-f98e57b490f2 2cc83395e9d546a3b7344bae7d7c886d 5946a38bd52e4b719c65bf8448d0032e - - -] Route path: '/{project_id}/limits', def    aults: {'action': u'index', 'controller': <cinder.api.openstack.wsgi.Resource object at 0x2c16510>} __call__ /usr/lib/python2.7/site-packages/routes/middleware.py:102
264 2014-06-19 10:47:08.576 7200 DEBUG routes.middleware [req-57998d77-27ad-4108-9773-f98e57b490f2 2cc83395e9d546a3b7344bae7d7c886d 5946a38bd52e4b719c65bf8448d0032e - - -] Match dict: {'action': u'index', 'contr    oller': <cinder.api.openstack.wsgi.Resource object at 0x2c16510>, 'project_id': u'5946a38bd52e4b719c65bf8448d0032e'} __call__ /usr/lib/python2.7/site-packages/routes/middleware.py:103
265 2014-06-19 10:47:08.576 7200 INFO cinder.api.openstack.wsgi [req-57998d77-27ad-4108-9773-f98e57b490f2 2cc83395e9d546a3b7344bae7d7c886d 5946a38bd52e4b719c65bf8448d0032e - - -] GET http://10.35.3.109:8776/v1/5    946a38bd52e4b719c65bf8448d0032e/limits
266 2014-06-19 10:47:08.576 7200 DEBUG cinder.api.openstack.wsgi [req-57998d77-27ad-4108-9773-f98e57b490f2 2cc83395e9d546a3b7344bae7d7c886d 5946a38bd52e4b719c65bf8448d0032e - - -] Empty body provided in request     get_body /usr/lib/python2.7/site-packages/cinder/api/openstack/wsgi.py:787
267 2014-06-19 10:47:08.589 7200 INFO cinder.api.openstack.wsgi [req-57998d77-27ad-4108-9773-f98e57b490f2 2cc83395e9d546a3b7344bae7d7c886d 5946a38bd52e4b719c65bf8448d0032e - - -] http://10.35.3.109:8776/v1/5946a    38bd52e4b719c65bf8448d0032e/limits returned with HTTP 200
268 2014-06-19 10:47:08.590 7200 INFO eventlet.wsgi.server [req-57998d77-27ad-4108-9773-f98e57b490f2 2cc83395e9d546a3b7344bae7d7c886d 5946a38bd52e4b719c65bf8448d0032e - - -] 10.35.3.109 - - [19/Jun/2014 10:47:08    ] "GET /v1/5946a38bd52e4b719c65bf8448d0032e/limits HTTP/1.1" 200 431 0.016105
269 2014-06-19 10:47:08.591 7200 INFO eventlet.wsgi.server [-] (7200) accepted ('10.35.3.109', 46258)


Thanks , 
Benny
