From: Dominik Mostowiec <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: radosgw - complete_multipart errors
Date: Thu, 31 Oct 2013 14:22:08 +0100
Message-ID: <CAMNMNTx6TCaxUng6wFYHm_TECQzK9+y_G0dTimDauoci_ucu9w@mail.gmail.com>
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
To: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi,
I have strange radosgw error:

======
2013-10-26 21:18:29.844676 7f637beaf700  0 setting object
tag=_ZPeVs7d6W8GjU8qKr4dsilbGeo6NOgw
2013-10-26 21:18:30.049588 7f637beaf700  0 WARNING: set_req_state_err
err_no=125 resorting to 500
2013-10-26 21:18:30.049738 7f637beaf700  2 req 61655:0.224186:s3:POST
/testbucket/files/image%20%286%29.jpeg:complete_multipart:http
status=500
2013-10-26 21:18:30.049975 7f637beaf700  1 ====== req done
req=0x11013d0 http_status=500 ======

It's similar to: http://tracker.ceph.com/issues/5439
This is the same bug?
My ceph version:
ceph version 0.56.6 (95a0bda7f007a33b0dc7adf4b330778fa1e5d70c)

Bug (5439) is fixed.
How to check (if I know commit
"72d4351ea5a470051e428ffc5531acfc7d1c7b6f" ) which CEPH version have
this fix.
In latest bobtail - 0.56.7 it is fixed?

---
Regards
Dominik
