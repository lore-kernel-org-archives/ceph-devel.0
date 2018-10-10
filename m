From: John Spray <jspray-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Does anyone use interactive CLI mode?
Date: Wed, 10 Oct 2018 15:19:55 +0100
Message-ID: <CALe9h7c5kJudfsQ6Vf_vczUG0CeoN8=dxznC=92RamBvxD9u0w@mail.gmail.com>
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
To: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi all,

Since time immemorial, the Ceph CLI has had a mode where when run with
no arguments, you just get an interactive prompt that lets you run
commands without "ceph" at the start.

I recently discovered that we actually broke this in Mimic[1], and it
seems that nobody noticed!

So the question is: does anyone actually use this feature?  It's not
particularly expensive to maintain, but it might be nice to have one
less path through the code if this is entirely unused.

Cheers,
John

1. https://github.com/ceph/ceph/pull/24521
