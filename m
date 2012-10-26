From: Josh Durgin <josh.durgin@inktank.com>
Subject: RE: RBD boot from volume weirdness in OpenStack
Date: Fri, 26 Oct 2012 09:30:59 -0700
Message-ID: <850f8c0ac745fd9af28ef34c40accb34@hq.newdream.net>
References: <CACkq2mryT7Nsqs3W5HJ-pTDHqyuDjn4_dqiDp3+zv9=Wd3TJZA@mail.gmail.com>
 <bdf1660d88c03cd19087407dd63ef973@hq.newdream.net>
 <CACkq2mqwBmkgBoddP6=7oUq1_eL0O4E6MswRn6kzOLxjsXMpCg@mail.gmail.com>
 <CACkq2monRqHPvXBw3bL35P142s2q98qiC+MpEE5qTnNaaLaYZw@mail.gmail.com>
 <5089761F.1010204@inktank.com>
 <CACkq2mp1Mo-Q2gKTXfHL4mskjPj-6DUgHf9mmcY+SR+4q_goug@mail.gmail.com>
 <60E83269D669544E8069A09CB69135EA03CF62@GDC-CLDMBX-P02.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ps79606.dreamhost.com ([66.33.206.83]:50769 "EHLO
	webmail.hq.newdream.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965257Ab2JZQbC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 12:31:02 -0400
In-Reply-To: <60E83269D669544E8069A09CB69135EA03CF62@GDC-CLDMBX-P02.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wiwynn.com
Cc: trhoden@gmail.com, ceph-devel@vger.kernel.org

On 2012-10-25 22:57, Eric_YH_Chen@wiwynn.com wrote:
> Dear Josh and Travis:
>
> I am trying to setup the openstack+ceph environment too, but I am not
> using devstack.
> I deploy the glance, cinder, nova, keystone into different servers.
> All the basic function works fine, I can import image, create volume
> and create virtual machine.
> It seems the glance and cinder access ceph block device correctly.
> (ceph version 0.53)
>
> But when I try to create an volume based on existed images, it 
> failed.
> I use the command in http://ceph.com/docs/master/rbd/rbd-openstack/
>
> root@glance:~# glance image-list
> 
> +--------------------------------------+---------------------+-------------+------------------+------------+--------+
> | ID                                   | Name                | Disk
> Format | Container Format | Size       | Status |
> 
> +--------------------------------------+---------------------+-------------+------------------+------------+--------+
> | cad779fc-c851-4581-ac4d-474c3773bf89 | Ubuntu-Precise-Raw  | raw
>     | bare             | 2147483648 | active |
> 
> +--------------------------------------+---------------------+-------------+------------------+------------+--------+
>
> root@glance:~# rbd info -p images 
> cad779fc-c851-4581-ac4d-474c3773bf89
> rbd image 'cad779fc-c851-4581-ac4d-474c3773bf89':
>         size 2048 MB in 256 objects
>         order 23 (8192 KB objects)
>         block_name_prefix: rbd_data.28c076755ff
>         format: 2
>         features: layering
>
> root@cinder:~# cinder create --image-id 
> cad779fc-c851-4581-ac4d-474c3773bf89 10
> root@cinder:~# cinder list
> 
> +--------------------------------------+-----------+----------------+------+-------------+--------------------------------------+
> |                  ID                  |   Status  |  Display Name  |
> Size | Volume Type |             Attached to              |
> 
> +--------------------------------------+-----------+----------------+------+-------------+--------------------------------------+
> | b8af3932-b27a-41e4-a2cc-082b78083f79 |   error   |      None      |
> 10  |     None    |                                      |
> 
> +--------------------------------------+-----------+----------------+------+-------------+--------------------------------------+
>
> Do you ever met this error message? Any suggestion is appreciated.
> Furthermore, I do not use cephx authentication, therefore, I didn't
> setup CEPH_ARGS.
> Is it possible to cause this issue?

I haven't seen this error before, but CEPH_ARGS certainly doesn't 
affect it.

> Thanks!
>
>
> =============/etc/cinder/cinder.conf =================
> [DEFAULT]
> rootwrap_config = /etc/cinder/rootwrap.conf
> api_paste_confg = /etc/cinder/api-paste.ini
> sql_connection = mysql://cinder:password@localhost:3306/cinder
> iscsi_helper = tgtadm
> volume_name_template = volume-%s
> volume_group = cinder-volumes
> verbose = True
> auth_strategy = keystone
> state_path = /var/lib/cinder
> volume_driver=cinder.volume.driver.RBDDriver
> rabbit_password = password
> my_ip = 172.17.123.12
> glance_host = 172.17.123.16
>
> == /var/log/cinder/cinder-volume.log ============
>
> 2012-10-26 13:48:37 17411 DEBUG cinder.manager [-] Running periodic
> task VolumeManager._publish_service_capabilities periodic_tasks
> /usr/lib/python2.7/dist-packages/cinder/manager.py:164
> 2012-10-26 13:48:37 17411 DEBUG cinder.manager [-] Running periodic
> task VolumeManager._report_driver_status periodic_tasks
> /usr/lib/python2.7/dist-packages/cinder/manager.py:164
> 2012-10-26 13:48:38 17411 DEBUG cinder.openstack.common.rpc.amqp [-]
> received {u'_context_roles': [u'KeystoneServiceAdmin',
> u'KeystoneAdmin', u'admin'], u'_context_request_id':
> u'req-ec369d9d-581e-488b-84f1-e218b03ef1ea', u'_context_quota_class':
> None, u'args': {u'image_id': u'cad779fc-c851-4581-ac4d-474c3773bf89',
> u'snapshot_id': None, u'volume_id':
> u'b8af3932-b27a-41e4-a2cc-082b78083f79'}, u'_context_auth_token':
> '<SANITIZED>', u'_context_is_admin': True, u'_context_project_id':
> u'eefa301a6a424e7da3d582649ad0e59e', u'_context_timestamp':
> u'2012-10-26T05:48:37.771007', u'_context_read_deleted': u'no',
> u'_context_user_id': u'fafd0583de8a4a1b93b924a6b2cb7eb5', u'method':
> u'create_volume', u'_context_remote_address': u'172.17.123.12'}
> _safe_log
> 
> /usr/lib/python2.7/dist-packages/cinder/openstack/common/rpc/common.py:195
> 2012-10-26 13:48:38 17411 DEBUG cinder.openstack.common.rpc.amqp [-]
> unpacked context: {'user_id': u'fafd0583de8a4a1b93b924a6b2cb7eb5',
> 'roles': [u'KeystoneServiceAdmin', u'KeystoneAdmin', u'admin'],
> 'timestamp': u'2012-10-26T05:48:37.771007', 'auth_token':
> '<SANITIZED>', 'remote_address': u'172.17.123.12', 'quota_class':
> None, 'is_admin': True, 'request_id':
> u'req-ec369d9d-581e-488b-84f1-e218b03ef1ea', 'project_id':
> u'eefa301a6a424e7da3d582649ad0e59e', 'read_deleted': u'no'} _safe_log
> 
> /usr/lib/python2.7/dist-packages/cinder/openstack/common/rpc/common.py:195
> 2012-10-26 13:48:38 INFO cinder.volume.manager
> [req-ec369d9d-581e-488b-84f1-e218b03ef1ea
> fafd0583de8a4a1b93b924a6b2cb7eb5 eefa301a6a424e7da3d582649ad0e59e]
> volume volume-b8af3932-b27a-41e4-a2cc-082b78083f79: creating
> 2012-10-26 13:48:38 DEBUG cinder.volume.manager
> [req-ec369d9d-581e-488b-84f1-e218b03ef1ea
> fafd0583de8a4a1b93b924a6b2cb7eb5 eefa301a6a424e7da3d582649ad0e59e]
> volume volume-b8af3932-b27a-41e4-a2cc-082b78083f79: creating lv of
> size 10G create_volume
> /usr/lib/python2.7/dist-packages/cinder/volume/manager.py:133
> 2012-10-26 13:48:38 17411 ERROR cinder.openstack.common.rpc.amqp [-]
> Exception during message handling
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> Traceback (most recent call last):
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> File
> 
> "/usr/lib/python2.7/dist-packages/cinder/openstack/common/rpc/amqp.py",
> line 276, in _process_data
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> rval = self.proxy.dispatch(ctxt, version, method, **args)
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> File
> 
> "/usr/lib/python2.7/dist-packages/cinder/openstack/common/rpc/dispatcher.py",
> line 145, in dispatch
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> return getattr(proxyobj, method)(ctxt, **kwargs)
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> File "/usr/lib/python2.7/dist-packages/cinder/volume/manager.py", 
> line
> 163, in create_volume
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> volume_ref['id'], {'status': 'error'})
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> File "/usr/lib/python2.7/contextlib.py", line 24, in __exit__
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> self.gen.next()
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> File "/usr/lib/python2.7/dist-packages/cinder/volume/manager.py", 
> line
> 146, in create_volume
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> image_location = image_service.get_location(context, image_id)
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> File "/usr/lib/python2.7/dist-packages/cinder/image/glance.py", line
> 194, in get_location
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> _reraise_translated_image_exception(image_id)
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> File "/usr/lib/python2.7/dist-packages/cinder/image/glance.py", line
> 192, in get_location
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> image_meta = client.call(context, 2, 'get', image_id)
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> File "/usr/lib/python2.7/dist-packages/cinder/image/glance.py", line
> 120, in call
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp     
> version)
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> File "/usr/lib/python2.7/dist-packages/cinder/image/glance.py", line
> 106, in _create_onetime_client
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> return _create_glance_client(context, self.host, self.port, version)
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> File "/usr/lib/python2.7/dist-packages/cinder/image/glance.py", line
> 65, in _create_glance_client
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> return glanceclient.Client(str(version), endpoint, **params)
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> File "/usr/lib/python2.7/dist-packages/glanceclient/client.py", line
> 22, in Client
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> return client_class(*args, **kwargs)
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> File "/usr/lib/python2.7/dist-packages/glanceclient/v2/client.py",
> line 37, in __init__
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> self._get_image_model())
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> File "/usr/lib/python2.7/dist-packages/glanceclient/v2/client.py",
> line 40, in _get_image_model
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> schema = self.schemas.get('image')
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> File "/usr/lib/python2.7/dist-packages/glanceclient/v2/schemas.py",
> line 53, in get
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> _, raw_schema = self.http_client.json_request('GET', uri)
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> File "/usr/lib/python2.7/dist-packages/glanceclient/common/http.py",
> line 187, in json_request
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> resp, body_iter = self._http_request(url, method, **kwargs)
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> File "/usr/lib/python2.7/dist-packages/glanceclient/common/http.py",
> line 149, in _http_request
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> conn.request(method, conn_url, **kwargs)
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> File "/usr/lib/python2.7/httplib.py", line 958, in request
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> self._send_request(method, url, body, headers)
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> File "/usr/lib/python2.7/httplib.py", line 992, in _send_request
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> self.endheaders(body)
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> File "/usr/lib/python2.7/httplib.py", line 954, in endheaders
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> self._send_output(message_body)
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> File "/usr/lib/python2.7/httplib.py", line 814, in _send_output
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> self.send(msg)
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> File "/usr/lib/python2.7/httplib.py", line 776, in send
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> self.connect()
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> File "/usr/lib/python2.7/httplib.py", line 757, in connect
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> self.timeout, self.source_address)
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> File "/usr/lib/python2.7/dist-packages/eventlet/green/socket.py", 
> line
> 52, in create_connection
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> sock.connect(sa)
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> File "/usr/lib/python2.7/dist-packages/eventlet/greenio.py", line 
> 179,
> in connect
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> timeout_exc=socket.timeout("timed out"))
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> File "/usr/lib/python2.7/dist-packages/eventlet/hubs/__init__.py",
> line 119, in trampoline
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> listener = hub.add(hub.WRITE, fileno, current.switch)
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> File "/usr/lib/python2.7/dist-packages/eventlet/hubs/epolls.py", line
> 46, in add
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> listener = BaseHub.add(self, evtype, fileno, cb)
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> File "/usr/lib/python2.7/dist-packages/eventlet/hubs/hub.py", line
> 126, in add
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> evtype, fileno, evtype))
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> RuntimeError: Second simultaneous write on fileno 8 detected.  Unless
> you really know what you're doing, make sure that only one 
> greenthread
> can write any particular socket.  Consider using a pools.Pool. If you
> do know what you're doing and want to disable this error, call
> eventlet.debug.hub_multiple_reader_prevention(False)
> 2012-10-26 13:48:38 17411 TRACE cinder.openstack.common.rpc.amqp
> 2012-10-26 13:49:37 17411 DEBUG cinder.manager [-] Running periodic
> task VolumeManager._publish_service_capabilities periodic_tasks
> /usr/lib/python2.7/dist-packages/cinder/manager.py:164
> 2012-10-26 13:49:37 17411 DEBUG cinder.manager [-] Running periodic
> task VolumeManager._report_driver_status periodic_tasks
> /usr/lib/python2.7/dist-packages/cinder/manager.py:164

There's nothing rbd-specific in this error - it hasn't reached the 
driver layer yet.
It could occur when creating a volume from an image with any backend.

It looks like some code path is failing to monkey-patch httplib for 
eventlib
properly. Could you file a bug in cinder about this?

Josh

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org
> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Travis Rhoden
> Sent: Friday, October 26, 2012 1:47 AM
> To: Josh Durgin
> Cc: ceph-devel
> Subject: Re: RBD boot from volume weirdness in OpenStack
>
> Thanks for the pointers Josh.
>
> Stupidly, I had not looked at those docs.  I forgot all about them
> since they didn't used to be there.  I was only using OpenStack docs
> and not the Ceph ones.  Looks like they are filled with great
> information.  You answered all my questions!  Thanks again.
>
>  - Travis

