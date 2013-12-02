From: Dominik Mostowiec <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: radosgw Segmentation fault on obj copy
Date: Mon, 2 Dec 2013 13:19:54 +0100
Message-ID: <CAMNMNTzEVkom0cBe_jepaE95hzVGys+8y+-PA+2dSsTqNwg=tA@mail.gmail.com>
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
I have strange problem.
Obj copy (0 size) killing radosgw.

Head for this file:
Content-Type: application/octet-stream
Server: Apache/2.2.22 (Ubuntu)
ETag: "d41d8cd98f00b204e9800998ecf8427e-0"
Last-Modified: 2013-12-01T10:37:15Z

rgw log.
2013-12-02 08:18:59.196651 7f5308ff1700  1 ====== starting new request
req=0x2be6fa0 =====
2013-12-02 08:18:59.196709 7f5308ff1700  2 req 237:0.000058::::initializing
2013-12-02 08:18:59.196752 7f5308ff1700 10 meta>> HTTP_X_AMZ_ACL=public-read
2013-12-02 08:18:59.196760 7f5308ff1700 10 meta>>
HTTP_X_AMZ_COPY_SOURCE=/testbucket/testfile.xml
2013-12-02 08:18:59.196766 7f5308ff1700 10 meta>>
HTTP_X_AMZ_METADATA_DIRECTIVE=COPY
2013-12-02 08:18:59.196771 7f5308ff1700 10 x>> x-amz-acl:public-read
2013-12-02 08:18:59.196772 7f5308ff1700 10 x>>
x-amz-copy-source:/testbucket/testfile.xml
2013-12-02 08:18:59.196773 7f5308ff1700 10 x>> x-amz-metadata-directive:COPY
2013-12-02 08:18:59.196786 7f5308ff1700 10
s->object=/testbucket/new_testfile.ini s->bucket=testbucket
2013-12-02 08:18:59.196792 7f5308ff1700  2 req 237:0.000141:s3:PUT
/testbucket/new_testfile.ini::getting op
2013-12-02 08:18:59.196797 7f5308ff1700  2 req 237:0.000146:s3:PUT
/testbucket/new_testfile.ini:copy_obj:authorizing
2013-12-02 08:18:59.200648 7f5308ff1700 10 get_canon_resource():
dest=/testbucket/new_testfile.ini
2013-12-02 08:18:59.200661 7f5308ff1700 10 auth_hdr:
PUT
1B2M2Y8AsgTpgAmY7PhCfg==
application/octet-stream
Mon, 02 Dec 2013 07:18:55 GMT
x-amz-acl:public-read
x-amz-copy-source:/testbucket/testfile.xml
x-amz-metadata-directive:COPY
/testbucket/new_testfile.ini
2013-12-02 08:18:59.200717 7f5308ff1700  2 req 237:0.004066:s3:PUT
/testbucket/new_testfile.ini:copy_obj:reading permissions
2013-12-02 08:18:59.203330 7f5308ff1700  2 req 237:0.006679:s3:PUT
/testbucket/new_testfile.ini:copy_obj:verifying op permissions
2013-12-02 08:18:59.207627 7f5308ff1700 10 manifest: total_size = 0
2013-12-02 08:18:59.207649 7f5308ff1700  5 Searching permissions for
uid=0 mask=1
2013-12-02 08:18:59.207652 7f5308ff1700  5 Found permission: 15
2013-12-02 08:18:59.207654 7f5308ff1700 10  uid=0 requested perm
(type)=1, policy perm=1, user_perm_mask=15, acl perm=1
2013-12-02 08:18:59.207669 7f5308ff1700  5 Searching permissions for
uid=0 mask=2
2013-12-02 08:18:59.207670 7f5308ff1700  5 Found permission: 15
2013-12-02 08:18:59.207671 7f5308ff1700 10  uid=0 requested perm
(type)=2, policy perm=2, user_perm_mask=15, acl perm=2
2013-12-02 08:18:59.207681 7f5308ff1700  2 req 237:0.011030:s3:PUT
/testbucket/new_testfile.ini:copy_obj:verifying op params
2013-12-02 08:18:59.207686 7f5308ff1700  2 req 237:0.011035:s3:PUT
/testbucket/new_testfile.ini:copy_obj:executing
2013-12-02 08:18:59.207699 7f5308ff1700 10 x>> x-amz-acl:public-read
2013-12-02 08:18:59.207704 7f5308ff1700 10 x>>
x-amz-copy-source:/testbucket/testfile.xml
2013-12-02 08:18:59.207709 7f5308ff1700 10 x>> x-amz-metadata-directive:COPY
2013-12-02 08:18:59.207759 7f5308ff1700  5 Copy object
testbucket(@.rgw.buckets[406250.1]):testfile.ini =>
testbucket(@.rgw.buckets[406250.1]):new_testfile.ini
2013-12-02 08:18:59.208903 7f5308ff1700 -1 *** Caught signal
(Segmentation fault) **
 in thread 7f5308ff1700


-- 
Regards
Dominik
