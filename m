From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: can't download from radosgw
Date: Mon, 28 Jan 2013 12:28:20 +0100
Message-ID: <CAJH6TXi90idR13oTxDQCfaSgJh3P8A4h44rHQZSt8uX9kLX02A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:63655 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100Ab3A1L2V (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Jan 2013 06:28:21 -0500
Received: by mail-wi0-f180.google.com with SMTP id hj13so1314624wib.7
        for <ceph-devel@vger.kernel.org>; Mon, 28 Jan 2013 03:28:20 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
i've uploaded a file via PHP and it was uploaded properly:

# radosgw-admin -n client.radosgw.gateway bucket stats --bucket=public2
{ "bucket": "public2",
  "pool": ".rgw.buckets",
  "id": "7523.1",
  "marker": "7523.1",
  "owner": "public2",
  "usage": { "rgw.main": { "size_kb": 36367,
          "size_kb_actual": 36376,
          "num_objects": 4}}}


(num_objects and size_kb_actual are increasing after each upload)

file was uploaded as PUBLIC:

Array
(
    [acl] => Array
        (
            [0] => Array
                (
                    [type] => Group
                    [uri] => http://acs.amazonaws.com/groups/global/AllUsers
                    [permission] => READ
                )

        )

)

but when trying to acces it with

http://mydomain/public2/shared/9780470398661.pdf

i'm receving a 403 error:


2013-01-28 12:22:27.757233 7fe8657c3700 15 Read
AccessControlPolicy<AccessControlPolicy
xmlns="http://s3.amazonaws.com/doc/2006-03-01/"><Owner><ID>public2</ID></Owner><AccessControlList><Grant><Grantee
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:type="Group"><URI>http://acs.amazonaws.com/groups/global/AllUsers</URI></Grantee><Permission>READ</Permission></Grant><Grant><Grantee
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:type="CanonicalUser"><ID>public2</ID></Grantee><Permission>FULL_CONTROL</Permission></Grant></AccessControlList></AccessControlPolicy>
2013-01-28 12:22:27.757251 7fe8657c3700  2 req 128:0.049367:s3:GET
/public2/shared/9780470398661.pdf:get_obj:verifying op permissions
2013-01-28 12:22:27.757262 7fe8657c3700  5 Searching permissions for
uid=anonymous mask=1
2013-01-28 12:22:27.757267 7fe8657c3700  5 Permissions for user not found
2013-01-28 12:22:27.757270 7fe8657c3700  5 Searching permissions for
group=1 mask=1
2013-01-28 12:22:27.757274 7fe8657c3700  5 Found permission: 1
2013-01-28 12:22:27.757277 7fe8657c3700  5 Getting permissions
id=anonymous owner=public2 perm=1
2013-01-28 12:22:27.757281 7fe8657c3700 10  uid=anonymous requested
perm (type)=1, policy perm=1, user_perm_mask=15, acl perm=1
2013-01-28 12:22:27.757288 7fe8657c3700  2 req 128:0.049404:s3:GET
/public2/shared/9780470398661.pdf:get_obj:verifying op params
2013-01-28 12:22:27.757294 7fe8657c3700  2 req 128:0.049411:s3:GET
/public2/shared/9780470398661.pdf:get_obj:executing
2013-01-28 12:22:27.757318 7fe8657c3700 20 get_obj_state:
rctx=0x3182eb0 obj=public2:shared/9780470398661.pdf state=0x319aae8
s->prefetch_data=1
2013-01-28 12:22:27.757328 7fe8657c3700 20 Read xattr: user.rgw.acl
2013-01-28 12:22:27.757331 7fe8657c3700 20 Read xattr: user.rgw.content_type
2013-01-28 12:22:27.757334 7fe8657c3700 20 Read xattr: user.rgw.etag
2013-01-28 12:22:27.757336 7fe8657c3700 20 Read xattr: user.rgw.idtag
2013-01-28 12:22:27.757339 7fe8657c3700 20 Read xattr: user.rgw.manifest
2013-01-28 12:22:27.757342 7fe8657c3700 20 Read xattr: user.rgw.shadow_name
2013-01-28 12:22:27.757351 7fe8657c3700 20 get_obj_state:
rctx=0x3182eb0 obj=public2:shared/9780470398661.pdf state=0x319aae8
s->prefetch_data=1
2013-01-28 12:22:27.757358 7fe8657c3700 20 get_obj_state:
rctx=0x3182eb0 obj=public2:shared/9780470398661.pdf state=0x319aae8
s->prefetch_data=1
2013-01-28 12:22:27.759162 7fe8657c3700  0 NOTICE: failed to send
response to client
2013-01-28 12:22:27.759186 7fe8657c3700  0 ERROR: s->cio->print()
returned err=-1
2013-01-28 12:22:27.759206 7fe8657c3700  0 ERROR: s->cio->print()
returned err=-1
2013-01-28 12:22:27.759211 7fe8657c3700  0 ERROR: s->cio->print()
returned err=-1
2013-01-28 12:22:27.759216 7fe8657c3700  0 ERROR: s->cio->print()
returned err=-1
2013-01-28 12:22:27.759268 7fe8657c3700  2 req 128:0.051384:s3:GET
/public2/shared/9780470398661.pdf:get_obj:http status=403
2013-01-28 12:22:27.759336 7fe8657c3700  1 ====== req done
req=0x3192980 http_status=403 ======
