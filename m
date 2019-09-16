From: lin zhou <hnuzhoulin2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: s3cmd upload file successed but return This multipart
 completion is already in progress
Date: Mon, 16 Sep 2019 17:29:08 +0800
Message-ID: <CAKO+7k0U-zphb0zfw6nderdJwGvw1YwUhQWU0WnEVsKzcYpgiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hi, cephers
recently when using s3cmd to upload a large file, last POST request
which meaned I have finished mutltipart upload.But in fact file upload
success.

some key points:
1.s3cmd send the POST request.but the server response spend 30s;why
some times this POST request need 30s to finish, most of this POST
request finished within 100ms
----- did it mean we face a performance bottleneck? we used ssd to
store index pool.
>  ceph version is 10.2.11
>   42 nodes, each has ten 8T sata and two SSD,
>    .rgw.buckets.data      61      899T     96.58        32644G     423943616
>    .rgw.buckets.index     63         0         0         7025G          5472

2.s3cmd retry send POST request which do not wait for the first POST request
3.why the server return 500 when send multi same POST request, how
about return 102?

the request list is below:

## nginx1
10.200.59.145 - [16/Sep/2019:14:00:05 +0800]
"hba3-backup-data0004-f.s3.nie.netease.com" "POST
/yaz4nalmsgsam8kfk5doca/backup/_realm_data.tar.gz.0?uploads HTTP/1.1"
200 303 789 "-" "-" "-" 0.191 0.191

10.200.59.145 - [16/Sep/2019:14:00:05 +0800]
"hba3-backup-data0004-f.s3.nie.netease.com" "PUT
/yaz4nalmsgsam8kfk5doca/backup/_realm_data.tar.gz.0?partNumber=1&uploadId=2~v6s8KbNeMA7RaXS_ntcUPtfP1BmXVr1
HTTP/1.1" 200 0 15729218 "-" "-" "-" 0.511 0.383
...
10.200.59.145 - [16/Sep/2019:14:01:07 +0800]
"hba3-backup-data0004-f.s3.nie.netease.com" "PUT
/yaz4nalmsgsam8kfk5doca/backup/_realm_data.tar.gz.0?partNumber=99&uploadId=2~v6s8KbNeMA7RaXS_ntcUPtfP1BmXVr1
HTTP/1.1" 200 0 15729218 "-" "-" "-" 0.511 0.383

## nginx2
10.200.59.145 - [16/Sep/2019:14:01:09 +0800]
"hba3-backup-data0004-f.s3.nie.netease.com" "PUT
/yaz4nalmsgsam8kfk5doca/backup/_realm_data.tar.gz.0?partNumber=100&uploadId=2~v6s8KbNeMA7RaXS_ntcUPtfP1BmXVr1
HTTP/1.1" 200 0 15729220 "-" "-" "-" 2.430 2.298
...
10.200.59.145 - [16/Sep/2019:14:03:43 +0800]
"hba3-backup-data0004-f.s3.nie.netease.com" "PUT
/yaz4nalmsgsam8kfk5doca/backup/_realm_data.tar.gz.0?partNumber=349&uploadId=2~v6s8KbNeMA7RaXS_ntcUPtfP1BmXVr1
HTTP/1.1" 200 0 1857220 "-" "-" "-" 0.160 0.155
10.200.59.145 - [16/Sep/2019:14:04:13 +0800]
"hba3-backup-data0004-f.s3.nie.netease.com" "POST
/yaz4nalmsgsam8kfk5doca/backup/_realm_data.tar.gz.0?uploadId=2~v6s8KbNeMA7RaXS_ntcUPtfP1BmXVr1
HTTP/1.1" 200 360 30520 "-" "-" "-" 30.225 30.223

## nginx3
10.200.59.145 - [16/Sep/2019:14:03:56 +0800]
"hba3-backup-data0004-f.s3.nie.netease.com" "POST
/yaz4nalmsgsam8kfk5doca/backup/_realm_data.tar.gz.0?uploadId=2~v6s8KbNeMA7RaXS_ntcUPtfP1BmXVr1
HTTP/1.1" 500 291 30520 "-" "-" "-" 0.012 0.011
10.200.59.145 - [16/Sep/2019:14:04:02 +0800]
"hba3-backup-data0004-f.s3.nie.netease.com" "POST
/yaz4nalmsgsam8kfk5doca/backup/_realm_data.tar.gz.0?uploadId=2~v6s8KbNeMA7RaXS_ntcUPtfP1BmXVr1
HTTP/1.1" 500 291 30520 "-" "-" "-" 0.012 0.012
10.200.59.145 - [16/Sep/2019:14:04:11 +0800]
"hba3-backup-data0004-f.s3.nie.netease.com" "POST
/yaz4nalmsgsam8kfk5doca/backup/_realm_data.tar.gz.0?uploadId=2~v6s8KbNeMA7RaXS_ntcUPtfP1BmXVr1
HTTP/1.1" 500 291 30520 "-" "-" "-" 0.012 0.012
10.200.59.145 - [16/Sep/2019:14:04:23 +0800]
"hba3-backup-data0004-f.s3.nie.netease.com" "POST
/yaz4nalmsgsam8kfk5doca/backup/_realm_data.tar.gz.0?uploadId=2~v6s8KbNeMA7RaXS_ntcUPtfP1BmXVr1
HTTP/1.1" 500 291 30520 "-" "-" "-" 0.013 0.013
10.200.59.145 - [16/Sep/2019:14:04:38 +0800]
"hba3-backup-data0004-f.s3.nie.netease.com" "POST
/yaz4nalmsgsam8kfk5doca/backup/_realm_data.tar.gz.0?uploadId=2~v6s8KbNeMA7RaXS_ntcUPtfP1BmXVr1
HTTP/1.1" 500 291 30520 "-" "-" "-" 0.013 0.013
