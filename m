From: Will Zhao <zhao6305-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: rgw expiration problem, a bug ?
Date: Thu, 17 Jan 2019 16:04:50 +0800
Message-ID: <CAGOEmcOqZ+eh8vw8Re0zc8q6HtxG23ZDj_=BOeyRENzj57TTng@mail.gmail.com>
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
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi all:
I found when I set the bucket expiration rule , after the expiration
date, when I upload a new object , it will be deleted , and I found
the related code like the following:
if (prefix_iter->second.expiration_date != boost::none) {
//we have checked it before
  Why  this should be true  ?   The new uploaded object should be deleted ?
is_expired = true;
} else {
is_expired = obj_has_expired(obj_iter->meta.mtime,
prefix_iter->second.expiration);
}
