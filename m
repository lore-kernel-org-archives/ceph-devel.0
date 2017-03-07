From: Xiaoxi Chen <superdebuger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Much more dentries than inodes, is that normal?
Date: Tue, 7 Mar 2017 17:17:54 +0800
Message-ID: <CAEYCsVL-_JihR5RcDPzajNhZk52sGdwHOxU1Xmsbb==fhMh39Q@mail.gmail.com>
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
To: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi,

      From the admin socket of mds, I got following data on our
production cephfs env, roughly we have 585K inodes and almost same
amount of caps, but we have>2x dentries than inodes.

      I am pretty sure we dont use hard link intensively (if any).
And the #ino match with "rados ls --pool $my_data_pool}.

      Thanks for any explanations, appreciate it.


"mds_mem": {
        "ino": 584974,
        "ino+": 1290944,
        "ino-": 705970,
        "dir": 25750,
        "dir+": 25750,
        "dir-": 0,
        "dn": 1291393,
        "dn+": 1997517,
        "dn-": 706124,
        "cap": 584560,
        "cap+": 2657008,
        "cap-": 2072448,
        "rss": 24599976,
        "heap": 166284,
        "malloc": 18446744073708721289,
        "buf": 0
    },



Xiaoxi
