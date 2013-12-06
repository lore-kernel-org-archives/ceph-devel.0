From: Dominik Mostowiec <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: recreate bucket error
Date: Fri, 6 Dec 2013 14:07:03 +0100
Message-ID: <CAMNMNTzt_yPoqOhgKpi9vioAXygzD_oKzhHxsh-WA6NCB7mOcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi,
In version dumpling upgraded from bobtail working create the same bucket.

root@vm-1:/etc/apache2/sites-enabled# s3 -u create testcreate
Bucket successfully created.
root@vm-1:/etc/apache2/sites-enabled# s3 -u create testcreate
Bucket successfully created.

I installed new dumpling cluster and:
root@s1:/var/log/radosgw# s3 -u create test1
Bucket successfully created.
root@s1:/var/log/radosgw# s3 -u create test1

ERROR: ErrorUnknown

In radosgw logs:

2013-12-06 13:59:56.083109 7f162d7c2700  1 ====== starting new request
req=0xb7d480 =====
2013-12-06 13:59:56.083227 7f162d7c2700  2 req 5:0.000119::PUT
/test1/::initializing
2013-12-06 13:59:56.083261 7f162d7c2700 10 meta>> HTTP_X_AMZ_DATE
2013-12-06 13:59:56.083274 7f162d7c2700 10 x>> x-amz-date:Fri, 06 Dec
2013 12:59:56 GMT
2013-12-06 13:59:56.083298 7f162d7c2700 10 s->object=<NULL> s->bucket=test1
2013-12-06 13:59:56.083307 7f162d7c2700  2 req 5:0.000199:s3:PUT
/test1/::getting op
2013-12-06 13:59:56.083315 7f162d7c2700  2 req 5:0.000207:s3:PUT
/test1/:create_bucket:authorizing
2013-12-06 13:59:56.091724 7f162d7c2700 10 get_canon_resource(): dest=
2013-12-06 13:59:56.091742 7f162d7c2700 10 auth_hdr:
PUT



x-amz-date:Fri, 06 Dec 2013 12:59:56 GMT
/test1/
2013-12-06 13:59:56.091836 7f162d7c2700  2 req 5:0.008728:s3:PUT
/test1/:create_bucket:reading permissions
2013-12-06 13:59:56.091848 7f162d7c2700  2 req 5:0.008740:s3:PUT
/test1/:create_bucket:verifying op mask
2013-12-06 13:59:56.091852 7f162d7c2700  2 req 5:0.008744:s3:PUT
/test1/:create_bucket:verifying op permissions
2013-12-06 13:59:56.093858 7f162d7c2700  2 req 5:0.010750:s3:PUT
/test1/:create_bucket:verifying op params
2013-12-06 13:59:56.093882 7f162d7c2700  2 req 5:0.010773:s3:PUT
/test1/:create_bucket:executing
2013-12-06 13:59:56.104819 7f162d7c2700  0 WARNING: couldn't find acl
header for object, generating default
2013-12-06 13:59:56.132625 7f162d7c2700  0 get_bucket_info returned -125
2013-12-06 13:59:56.132656 7f162d7c2700  0 WARNING: set_req_state_err
err_no=125 resorting to 500
2013-12-06 13:59:56.132693 7f162d7c2700  2 req 5:0.049584:s3:PUT
/test1/:create_bucket:http status=500
2013-12-06 13:59:56.132890 7f162d7c2700  1 ====== req done
req=0xb7d480 http_status=500 ======

-- 
Regards
Dominik
