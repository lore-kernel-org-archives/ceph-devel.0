From: "Zhou, Yuan" <yuan.zhou@intel.com>
Subject: Issue on RGW 500 error: flush_read_list():
 d->client_c->handle_data() returned -5
Date: Wed, 19 Jul 2017 14:45:54 +0000
Message-ID: <06681238D8946F44A60AA400760A1CBF12393956@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:63836 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754891AbdGSOqt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 19 Jul 2017 10:46:49 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hello, 

Trying to do some tests with bigdata + S3a + RGW here and ran into a weird 500 error. I checked the log and find the error was due to:

ERROR: flush_read_list(): d->client_c->handle_data() returned -5

After checking the code this function seems trying to send data back to client but something wrong happen. Was this because the connection between client and RGW was closed before the data transferring finish? 

Is there a way to do some debug on this?  

I'm testing with Ceph 10.2.7, the data pool was using EC(3 + 2). Any comments would be appreciated!

The full log is listed as below:

2017-07-19 10:39:53.850687 7f5cfa7fc700  1 ====== starting new request req=0x7f5cfa7f6710 =====
2017-07-19 10:39:53.850698 7f5cfa7fc700  2 req 19279:0.000011::GET /test-bucket/tpcds_bin_partitioned_orc_3.db/store_sales/ss_sold_date_sk%3D2451894/000000_0::initializing 
for trans_id = tx000000000000000004b4f-00596ec679-47a5c-default
2017-07-19 10:39:53.850704 7f5cfa7fc700 10 rgw api priority: s3=5 s3website=4
2017-07-19 10:39:53.850706 7f5cfa7fc700 10 host=10.0.2.254
2017-07-19 10:39:53.850708 7f5cfa7fc700 20 subdomain= domain= in_hosted_domain=0 in_hosted_domain_s3website=0
2017-07-19 10:39:53.850710 7f5cfa7fc700 20 final domain/bucket subdomain= domain= in_hosted_domain=0 in_hosted_domain_s3website=0 s->info.domain= s->info.request_uri=/test-
bucket/tpcds_bin_partitioned_orc_3.db/store_sales/ss_sold_date_sk%3D2451894/000000_0
2017-07-19 10:39:53.850726 7f5cfa7fc700 20 get_handler handler=22RGWHandler_REST_Obj_S3
2017-07-19 10:39:53.850728 7f5cfa7fc700 10 handler=22RGWHandler_REST_Obj_S3
2017-07-19 10:39:53.850729 7f5cfa7fc700  2 req 19279:0.000042:s3:GET /test-bucket/tpcds_bin_partitioned_orc_3.db/store_sales/ss_sold_date_sk%3D2451894/000000_0::getting op 
0
2017-07-19 10:39:53.850732 7f5cfa7fc700 10 op=21RGWGetObj_ObjStore_S3
2017-07-19 10:39:53.850734 7f5cfa7fc700  2 req 19279:0.000047:s3:GET /test-bucket/tpcds_bin_partitioned_orc_3.db/store_sales/ss_sold_date_sk%3D2451894/000000_0:get_obj:auth
orizing
2017-07-19 10:39:53.850751 7f5cfa7fc700 10 get_canon_resource(): dest=/test-bucket/tpcds_bin_partitioned_orc_3.db/store_sales/ss_sold_date_sk%3D2451894/000000_0
2017-07-19 10:39:53.850753 7f5cfa7fc700 10 auth_hdr:
GET

application/x-www-form-urlencoded; charset=utf-8
Wed, 19 Jul 2017 02:35:49 GMT
/test-bucket/tpcds_bin_partitioned_orc_3.db/store_sales/ss_sold_date_sk%3D2451894/000000_0
2017-07-19 10:39:53.850778 7f5cfa7fc700 15 calculated digest=REpW8++O3jzMIU6iaPpqIFjpwxU=
2017-07-19 10:39:53.850780 7f5cfa7fc700 15 auth_sign=REpW8++O3jzMIU6iaPpqIFjpwxU=
2017-07-19 10:39:53.850780 7f5cfa7fc700 15 compare=0
2017-07-19 10:39:53.850782 7f5cfa7fc700  2 req 19279:0.000095:s3:GET /test-bucket/tpcds_bin_partitioned_orc_3.db/store_sales/ss_sold_date_sk%3D2451894/000000_0:get_obj:norm
alizing buckets and tenants
2017-07-19 10:39:53.850784 7f5cfa7fc700 10 s->object=tpcds_bin_partitioned_orc_3.db/store_sales/ss_sold_date_sk=2451894/000000_0 s->bucket=test-bucket
2017-07-19 10:39:53.850797 7f5cfa7fc700  2 req 19279:0.000099:s3:GET /test-bucket/tpcds_bin_partitioned_orc_3.db/store_sales/ss_sold_date_sk%3D2451894/000000_0:get_obj:init
permissions
2017-07-19 10:39:53.850815 7f5cfa7fc700 15 decode_policy Read AccessControlPolicy<AccessControlPolicy xmlns="http://s3.amazonaws.com/doc/2006-03-01/"><Owner><ID>johndoe</ID
><DisplayName>John Doe</DisplayName></Owner><AccessControlList><Grant><Grantee xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="CanonicalUser"><ID>johndoe</I
D><DisplayName>John Doe</DisplayName></Grantee><Permission>FULL_CONTROL</Permission></Grant></AccessControlList></AccessControlPolicy>
2017-07-19 10:39:53.850822 7f5cfa7fc700  2 req 19279:0.000135:s3:GET /test-bucket/tpcds_bin_partitioned_orc_3.db/store_sales/ss_sold_date_sk%3D2451894/000000_0:get_obj:reca
lculating target
2017-07-19 10:39:53.850824 7f5cfa7fc700  2 req 19279:0.000137:s3:GET /test-bucket/tpcds_bin_partitioned_orc_3.db/store_sales/ss_sold_date_sk%3D2451894/000000_0:get_obj:read
ing permissions
2017-07-19 10:39:53.850838 7f5cfa7fc700 20 get_obj_state: rctx=0x7f5cfa7f5e50 obj=test-bucket:tpcds_bin_partitioned_orc_3.db/store_sales/ss_sold_date_sk=2451894/000000_0 st
ate=0x7f5cd800ac98 s->prefetch_data=1
2017-07-19 10:39:53.853125 7f5cfa7fc700 10 manifest: total_size = 479111
2017-07-19 10:39:53.853136 7f5cfa7fc700 20 get_obj_state: setting s->obj_tag to c48d4021-fed2-4f05-865a-3b26715fe3e6.233739.2645046^@
2017-07-19 10:39:53.853144 7f5cfa7fc700 15 decode_policy Read AccessControlPolicy<AccessControlPolicy xmlns="http://s3.amazonaws.com/doc/2006-03-01/"><Owner><ID>johndoe</ID
><DisplayName>John Doe</DisplayName></Owner><AccessControlList><Grant><Grantee xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="CanonicalUser"><ID>johndoe</I
D><DisplayName>John Doe</DisplayName></Grantee><Permission>FULL_CONTROL</Permission></Grant></AccessControlList></AccessControlPolicy>
2017-07-19 10:39:53.853150 7f5cfa7fc700  2 req 19279:0.002463:s3:GET /test-bucket/tpcds_bin_partitioned_orc_3.db/store_sales/ss_sold_date_sk%3D2451894/000000_0:get_obj:init
op
2017-07-19 10:39:53.853154 7f5cfa7fc700  2 req 19279:0.002467:s3:GET /test-bucket/tpcds_bin_partitioned_orc_3.db/store_sales/ss_sold_date_sk%3D2451894/000000_0:get_obj:veri
fying op mask
2017-07-19 10:39:53.853155 7f5cfa7fc700 20 required_mask= 1 user.op_mask=7
2017-07-19 10:39:53.853156 7f5cfa7fc700  2 req 19279:0.002469:s3:GET /test-bucket/tpcds_bin_partitioned_orc_3.db/store_sales/ss_sold_date_sk%3D2451894/000000_0:get_obj:veri
fying op permissions
2017-07-19 10:39:53.853161 7f5cfa7fc700  5 Searching permissions for uid=johndoe mask=49
2017-07-19 10:39:53.853163 7f5cfa7fc700  5 Found permission: 15
2017-07-19 10:39:53.853163 7f5cfa7fc700  5 Searching permissions for group=1 mask=49
2017-07-19 10:39:53.853165 7f5cfa7fc700  5 Permissions for group not found
2017-07-19 10:39:53.853166 7f5cfa7fc700  5 Searching permissions for group=2 mask=49
2017-07-19 10:39:53.853167 7f5cfa7fc700  5 Permissions for group not found
2017-07-19 10:39:53.853167 7f5cfa7fc700  5 Getting permissions id=johndoe owner=johndoe perm=1
2017-07-19 10:39:53.853168 7f5cfa7fc700 10  uid=johndoe requested perm (type)=1, policy perm=1, user_perm_mask=15, acl perm=1
2017-07-19 10:39:53.853169 7f5cfa7fc700  2 req 19279:0.002482:s3:GET /test-bucket/tpcds_bin_partitioned_orc_3.db/store_sales/ss_sold_date_sk%3D2451894/000000_0:get_obj:veri
fying op params
2017-07-19 10:39:53.853170 7f5cfa7fc700  2 req 19279:0.002483:s3:GET /test-bucket/tpcds_bin_partitioned_orc_3.db/store_sales/ss_sold_date_sk%3D2451894/000000_0:get_obj:pre-
executing
2017-07-19 10:39:53.853171 7f5cfa7fc700  2 req 19279:0.002484:s3:GET /test-bucket/tpcds_bin_partitioned_orc_3.db/store_sales/ss_sold_date_sk%3D2451894/000000_0:get_obj:exec
uting
2017-07-19 10:39:53.853178 7f5cfa7fc700 20 get_obj_state: rctx=0x7f5cfa7f5e50 obj=test-bucket:tpcds_bin_partitioned_orc_3.db/store_sales/ss_sold_date_sk=2451894/000000_0 st
ate=0x7f5cd800ac98 s->prefetch_data=1
2017-07-19 10:39:53.853191 7f5cfa7fc700 20 Read xattr: user.rgw.acl
2017-07-19 10:39:53.853192 7f5cfa7fc700 20 Read xattr: user.rgw.content_type
2017-07-19 10:39:53.853193 7f5cfa7fc700 20 Read xattr: user.rgw.etag
2017-07-19 10:39:53.853193 7f5cfa7fc700 20 Read xattr: user.rgw.idtag
2017-07-19 10:39:53.853193 7f5cfa7fc700 20 Read xattr: user.rgw.manifest
2017-07-19 10:39:53.853194 7f5cfa7fc700 20 Read xattr: user.rgw.pg_ver
2017-07-19 10:39:53.853195 7f5cfa7fc700 20 Read xattr: user.rgw.source_zone
2017-07-19 10:39:53.853195 7f5cfa7fc700 20 Read xattr: user.rgw.x-amz-copy-source
2017-07-19 10:39:53.853195 7f5cfa7fc700 20 Read xattr: user.rgw.x-amz-metadata-directive
2017-07-19 10:39:53.853200 7f5cfa7fc700 20 get_obj_state: rctx=0x7f5cfa7f5e50 obj=test-bucket:tpcds_bin_partitioned_orc_3.db/store_sales/ss_sold_date_sk=2451894/000000_0 st
ate=0x7f5cd800ac98 s->prefetch_data=1
2017-07-19 10:39:53.853931 7f5cfa7fc700 20 
rados->get_obj_iterate_cb oid=c48d4021-fed2-4f05-865a-3b26715fe3e6.233798.8__shadow_.PWx_nnmtTuV9yTPbfQMo81Olo9U34Js_1 
obj-ofs=458976 read_ofs=0 len=20135
2017-07-19 10:39:53.854036 7f5cfa7fc700 20 RGWObjManifest::operator++(): rule->part_size=0 rules.size()=1
2017-07-19 10:39:53.854040 7f5cfa7fc700 20 RGWObjManifest::operator++(): result: ofs=479111 stripe_ofs=479111 part_ofs=0 rule->part_size=0
2017-07-19 10:39:53.855328 7f5e7dffb700 20 get_obj_aio_completion_cb: io completion ofs=458976 len=20135
2017-07-19 10:39:53.855395 7f5cfa7fc700  0 ERROR: flush_read_list(): d->client_c->handle_data() returned -5
2017-07-19 10:39:53.855403 7f5cfa7fc700 10 get_obj_iterate() r=-5, canceling all io
2017-07-19 10:39:53.855405 7f5cfa7fc700 20 get_obj_data::cancel_all_io()
2017-07-19 10:39:53.855409 7f5cfa7fc700  0 WARNING: set_req_state_err err_no=5 resorting to 500
2017-07-19 10:39:53.855430 7f5cfa7fc700  0 ERROR: s->cio->send_content_length() returned err=-5
2017-07-19 10:39:53.855432 7f5cfa7fc700  0 ERROR: s->cio->print() returned err=-5
2017-07-19 10:39:53.855433 7f5cfa7fc700  0 ERROR: STREAM_IO(s)->print() returned err=-5
2017-07-19 10:39:53.855440 7f5cfa7fc700  0 ERROR: STREAM_IO(s)->complete_header() returned err=-5
2017-07-19 10:39:53.855465 7f5cfa7fc700  2 req 19279:0.004778:s3:GET /test-bucket/tpcds_bin_partitioned_orc_3.db/store_sales/ss_sold_date_sk%3D2451894/000000_0:get_obj:comp
leting
2017-07-19 10:39:53.855469 7f5cfa7fc700  2 req 19279:0.004782:s3:GET /test-bucket/tpcds_bin_partitioned_orc_3.db/store_sales/ss_sold_date_sk%3D2451894/000000_0:get_obj:op s
tatus=-5
2017-07-19 10:39:53.855470 7f5cfa7fc700  2 req 19279:0.004783:s3:GET /test-bucket/tpcds_bin_partitioned_orc_3.db/store_sales/ss_sold_date_sk%3D2451894/000000_0:get_obj:http
status=500
2017-07-19 10:39:53.855474 7f5cfa7fc700  1 ====== req done req=0x7f5cfa7f6710 op status=-5 http_status=500 ======


Thanks, -yuan

