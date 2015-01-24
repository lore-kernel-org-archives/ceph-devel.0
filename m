From: Yehuda Sadeh <yehuda@redhat.com>
Subject: Re: Hadoop with RGW failing for s3 protocol
Date: Sat, 24 Jan 2015 12:38:13 -0800
Message-ID: <CABBk=J_+D_m64hmJe6vaEkbCf5uouqc=n2ZLwAuBOc2cHow_nA@mail.gmail.com>
References: <AE39FC098EAC574B88212DCCB67F06AF0A506A94@SACMBXIP02.sdcorp.global.sandisk.com>
	<AE39FC098EAC574B88212DCCB67F06AF0A507852@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:40385 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbbAXUiO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 24 Jan 2015 15:38:14 -0500
Received: by mail-pd0-f176.google.com with SMTP id y10so4378152pdj.7
        for <ceph-devel@vger.kernel.org>; Sat, 24 Jan 2015 12:38:13 -0800 (PST)
In-Reply-To: <AE39FC098EAC574B88212DCCB67F06AF0A507852@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dhiraj Kamble <Dhiraj.Kamble@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hadoop is running the following:

String name = (String) object.getMetadata(FILE_SYSTEM_NAME);
if (!FILE_SYSTEM_VALUE.equals(name)) {
throw new S3FileSystemException("Not a Hadoop S3 file.");
}

Check if there exists such a metadata, and whether it's as expected.

Yehuda

On Sat, Jan 24, 2015 at 11:59 AM, Dhiraj Kamble
<Dhiraj.Kamble@sandisk.com> wrote:
> Hi,
>
> I made some changes(small dirty hack) to RGW code  to parse the "%2F" sent by jets3t for hadoop s3:// protocol
> Now RGW sends back a http 200 response and I am able to see the required files in the rgw logs; but hadoop complains as "Not a Hadoop S3 file."
>
> In the ceph cluster I created buckets and files using boto.
> Am I missing anything here ?
>
> Regards,
> Dhiraj
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Dhiraj Kamble
> Sent: Friday, January 23, 2015 10:33 AM
> To: ceph-devel@vger.kernel.org
> Subject: Hadoop with RGW failing for s3 protocol
>
> Hi
>
> I am facing some issues when using hadoop with Ceph rgw. I am able execute basic hadoop commands like put, get, list etc when I use the "s3n"; but the same fails when I use "s3" protocol.
> From the logs its looks like "%2F" character parsing is causing the issue.
>
> Am using Hadoop 2.5.2 and Jets3t library version 0.9.0
>
> root@ip-10-15-16-80:/home/ubuntu/build/ceph/src# ./ceph -v
> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH *** ceph version 0.90-877-gc219c43 (c219c43cc2943c794378214d77566e3f0d3f394a)
>
> ubuntu@ip-10-15-16-76:~$ hdfs dfs -ls s3n://bucket1/ Found 2 items
> -rw-rw-rw-   1         12 2015-01-22 13:42 s3n://bucket1/hello.txt
> -rw-rw-rw-   1         14 2015-01-22 13:42 s3n://bucket1/test.txt
> ubuntu@ip-10-15-16-76:~$
>
> ubuntu@ip-10-15-16-76:~$ hdfs dfs -ls s3://bucket1/       <<<  fails
> ls: `s3://bucket1/': No such file or directory ubuntu@ip-10-15-16-76:~$
>
> Apache Access Log:
> For s3n - this one succeeds
> 10.15.16.76 l - [22/Jan/2015:13:43:43 +0000] "GET /?max-keys=1000&prefix&delimiter=%2F HTTP/1.1" 200 783 "{Referer}i" "JetS3t/0.9.0 (Linux/3.13.0-36-generic; amd64; en; JVM 1.8.0_25)"
>
> For s3 - this one fails
> 10.15.16.76 l - [22/Jan/2015:13:45:27 +0000] "GET /%2F HTTP/1.1" 404 75 "{Referer}i" "JetS3t/0.9.0 (Linux/3.13.0-36-generic; amd64; en; JVM 1.8.0_25)"
>
> User Info:
> { "user_id": "admin",
>   "display_name": "Admin",
>   "email": "",
>   "suspended": 0,
>   "max_buckets": 1000,
>   "auid": 0,
>   "subusers": [],
>   "keys": [
>         { "user": "admin",
>           "access_key": "QQIAIHB7HRAPLGFY5GQQ",
>           "secret_key": "ZwmskCFP1RUIJjacAbWTpa0I1FOhkDcRsr4nqNPZ"}],
>   "swift_keys": [],
>   "caps": [],
>   "op_mask": "read, write, delete",
>   "default_placement": "",
>   "placement_tags": [],
>   "bucket_quota": { "enabled": false,
>       "max_size_kb": -1,
>       "max_objects": -1},
>   "user_quota": { "enabled": false,
>       "max_size_kb": -1,
>       "max_objects": -1},
>   "temp_url_keys": []}
>
> RGW Logs:
>
> 2015-01-22 13:45:27.108999 7f14857fa700 20 enqueued request req=0x7f14680128d0
> 2015-01-22 13:45:27.109013 7f14857fa700 20 RGWWQ:
> 2015-01-22 13:45:27.109015 7f14857fa700 20 req: 0x7f14680128d0
> 2015-01-22 13:45:27.109020 7f14857fa700 10 allocated request req=0x7f1468012bd0
> 2015-01-22 13:45:27.109031 7f1467fff700 20 dequeued request req=0x7f14680128d0
> 2015-01-22 13:45:27.109037 7f1467fff700 20 RGWWQ: empty
> 2015-01-22 13:45:27.109082 7f1467fff700 20 CONTEXT_DOCUMENT_ROOT=/home/ubuntu/build/ceph/giant/src/out/htdocs
> 2015-01-22 13:45:27.109087 7f1467fff700 20 CONTEXT_PREFIX=
> 2015-01-22 13:45:27.109088 7f1467fff700 20 DOCUMENT_ROOT=/home/ubuntu/build/ceph/giant/src/out/htdocs
> 2015-01-22 13:45:27.109089 7f1467fff700 20 FCGI_ROLE=RESPONDER
> 2015-01-22 13:45:27.109090 7f1467fff700 20 GATEWAY_INTERFACE=CGI/1.1
> 2015-01-22 13:45:27.109091 7f1467fff700 20 HTTP_AUTHORIZATION=AWS QQIAIHB7HRAPLGFY5GQQ:sHYZL3gMUgxyPkdamA9qVaCmQiI=
> 2015-01-22 13:45:27.109092 7f1467fff700 20 HTTP_CONNECTION=Keep-Alive
> 2015-01-22 13:45:27.109092 7f1467fff700 20 HTTP_DATE=Thu, 22 Jan 2015 13:45:27 GMT
> 2015-01-22 13:45:27.109094 7f1467fff700 20 HTTP_HOST=bucket1.ip-10-15-16-80:8090
> 2015-01-22 13:45:27.109095 7f1467fff700 20 HTTP_USER_AGENT=JetS3t/0.9.0 (Linux/3.13.0-36-generic; amd64; en; JVM 1.8.0_25)
> 2015-01-22 13:45:27.109096 7f1467fff700 20 LD_LIBRARY_PATH=.libs
> 2015-01-22 13:45:27.109097 7f1467fff700 20 PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
> 2015-01-22 13:45:27.109098 7f1467fff700 20 QUERY_STRING=page=&params=
> 2015-01-22 13:45:27.109099 7f1467fff700 20 REMOTE_ADDR=10.15.16.76
> 2015-01-22 13:45:27.109100 7f1467fff700 20 REMOTE_PORT=59026
> 2015-01-22 13:45:27.109101 7f1467fff700 20 REQUEST_METHOD=GET
> 2015-01-22 13:45:27.109101 7f1467fff700 20 REQUEST_SCHEME=http
> 2015-01-22 13:45:27.109102 7f1467fff700 20 REQUEST_URI=/%2F
> 2015-01-22 13:45:27.109102 7f1467fff700 20 RGW_LOG_LEVEL=30
> 2015-01-22 13:45:27.109103 7f1467fff700 20 RGW_PRINT_CONTINUE=yes
> 2015-01-22 13:45:27.109103 7f1467fff700 20 RGW_SHOULD_LOG=yes
> 2015-01-22 13:45:27.109104 7f1467fff700 20 SCRIPT_FILENAME=/home/ubuntu/build/ceph/giant/src/out/htdocs/rgw.fcgi
> 2015-01-22 13:45:27.109104 7f1467fff700 20 SCRIPT_NAME=//
> 2015-01-22 13:45:27.109105 7f1467fff700 20 SCRIPT_URI=http://bucket1.ip-10-15-16-80:8090//
> 2015-01-22 13:45:27.109105 7f1467fff700 20 SCRIPT_URL=//
> 2015-01-22 13:45:27.109106 7f1467fff700 20 SERVER_ADDR=10.15.16.80
> 2015-01-22 13:45:27.109106 7f1467fff700 20 SERVER_ADMIN=[no address given]
> 2015-01-22 13:45:27.109107 7f1467fff700 20 SERVER_NAME=bucket1.ip-10-15-16-80
> 2015-01-22 13:45:27.109107 7f1467fff700 20 SERVER_PORT=8090
> 2015-01-22 13:45:27.109108 7f1467fff700 20 SERVER_PROTOCOL=HTTP/1.1
> 2015-01-22 13:45:27.109108 7f1467fff700 20 SERVER_SIGNATURE=
> 2015-01-22 13:45:27.109109 7f1467fff700 20 SERVER_SOFTWARE=Apache/2.4.7 (Ubuntu) mod_fastcgi/mod_fastcgi-SNAP-0910052141
> 2015-01-22 13:45:27.109110 7f1467fff700  1 ====== starting new request req=0x7f14680128d0 =====
> 2015-01-22 13:45:27.109131 7f1467fff700  2 req 9:0.000020::GET /%2F::initializing
> 2015-01-22 13:45:27.109135 7f1467fff700 10 host=bucket1.ip-10-15-16-80:8090 rgw_dns_name=ip-10-15-16-80
> 2015-01-22 13:45:27.109183 7f1467fff700 10 s->object=/ s->bucket=bucket1
> 2015-01-22 13:45:27.109189 7f1467fff700  2 req 9:0.000078:s3:GET /%2F::getting op
> 2015-01-22 13:45:27.109197 7f1467fff700  2 req 9:0.000086:s3:GET /%2F:get_obj:authorizing
> 2015-01-22 13:45:27.109237 7f1467fff700 10 get_canon_resource(): dest=/bucket1/%2F
> 2015-01-22 13:45:27.109239 7f1467fff700 10 auth_hdr:
> GET
>
>
> Thu, 22 Jan 2015 13:45:27 GMT
> /bucket1/%2F
> 2015-01-22 13:45:27.109300 7f1467fff700 15 calculated digest=sHYZL3gMUgxyPkdamA9qVaCmQiI=
> 2015-01-22 13:45:27.109302 7f1467fff700 15 auth_sign=sHYZL3gMUgxyPkdamA9qVaCmQiI=
> 2015-01-22 13:45:27.109303 7f1467fff700 15 compare=0
> 2015-01-22 13:45:27.109305 7f1467fff700  2 req 9:0.000195:s3:GET /%2F:get_obj:reading permissions
> 2015-01-22 13:45:27.109348 7f1467fff700 15 Read AccessControlPolicy<AccessControlPolicy xmlns="http://s3.amazonaws.com/doc/2006-03-01/"><Owner><ID>admin</ID><DisplayName>Admin</DisplayName></Owner><AccessControlList><Grant><Grantee xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="CanonicalUser"><ID>admin</ID><DisplayName>Admin</DisplayName></Grantee><Permission>FULL_CONTROL</Permission></Grant></AccessControlList></AccessControlPolicy>
> 2015-01-22 13:45:27.109384 7f1467fff700 20 get_obj_state: rctx=0x7f1467ffe100 obj=bucket1:/ state=0x7f141800dc48 s->prefetch_data=1
> 2015-01-22 13:45:27.110103 7f1467fff700 15 Read AccessControlPolicy<AccessControlPolicy xmlns="http://s3.amazonaws.com/doc/2006-03-01/"><Owner><ID>admin</ID><DisplayName>Admin</DisplayName></Owner><AccessControlList><Grant><Grantee xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="CanonicalUser"><ID>admin</ID><DisplayName>Admin</DisplayName></Grantee><Permission>FULL_CONTROL</Permission></Grant></AccessControlList></AccessControlPolicy>
> 2015-01-22 13:45:27.110117 7f1467fff700 10 read_permissions on bucket1(@{i=.rgw.buckets.index,e=.rgw.buckets.extra}.rgw.buckets[default.4110.1]):/ only_bucket=0 ret=-2
> 2015-01-22 13:45:27.110144 7f1467fff700  2 req 9:0.001033:s3:GET /%2F:get_obj:http status=404
> 2015-01-22 13:45:27.110154 7f1467fff700  1 ====== req done req=0x7f14680128d0 http_status=404 ======
> 2015-01-22 13:45:27.110164 7f1467fff700 20 process_request() returned -2
> 2015-01-22 13:45:29.346572 7f1679ffb700  2 RGWDataChangesLog::ChangesRenewThread: start
>
>
> Regards,
> Dhiraj
>
>
> Regards,
> Dhiraj
>
>
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
