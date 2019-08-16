From: Jeff Layton <jlayton-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: deprecating inline_data support for CephFS
Date: Fri, 16 Aug 2019 07:15:18 -0400
Message-ID: <e392e00ed22ba37c37208988cf5a095150f6c45b.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-a8pt6IJUokc@public.gmane.org>
List-Archive: <https://lists.ceph.io/hyperkitty/list/ceph-users-a8pt6IJUokc@public.gmane.org/>
List-Help: <mailto:ceph-users-request-a8pt6IJUokc@public.gmane.org?subject=help>
List-Post: <mailto:ceph-users-a8pt6IJUokc@public.gmane.org>
List-Subscribe: <mailto:ceph-users-join-a8pt6IJUokc@public.gmane.org>
List-Unsubscribe: <mailto:ceph-users-leave-a8pt6IJUokc@public.gmane.org>
To: ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
Cc: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dev-a8pt6IJUokc@public.gmane.org" <dev-a8pt6IJUokc@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

A couple of weeks ago, I sent a request to the mailing list asking
whether anyone was using the inline_data support in cephfs:

    https://docs.ceph.com/docs/mimic/cephfs/experimental-features/#inline-data

I got exactly zero responses, so I'm going to formally propose that we
move to start deprecating this feature for Octopus.

Why deprecate this feature?
===========================
While the userland clients have support for both reading and writing,
the kernel only has support for reading, and aggressively uninlines
everything as soon as it needs to do any writing. That uninlining has
some rather nasty potential race conditions too that could cause data
corruption.

We could work to fix this, and maybe add write support for the kernel,
but it adds a lot of complexity to the read and write codepaths in the
clients, which are already pretty complex. Given that there isn't a lot
of interest in this feature, I think we ought to just pull the plug on
it.

How should we do this?
======================
We should start by disabling this feature in master for Octopus. 

In particular, we should stop allowing users to call "fs set inline_data
true" on filesystems where it's disabled, and maybe throw a loud warning
about the feature being deprecated if the mds is started on a filesystem
that has it enabled.

We could also consider creating a utility to crawl an existing
filesystem and uninline anything there, if there was need for it.

Then, in a few release cycles, once we're past the point where someone
can upgrade directly from Nautilus (release Q or R?) we'd rip out
support for this feature entirely.

Thoughts, comments, questions welcome.
-- 
Jeff Layton <jlayton-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
_______________________________________________
ceph-users mailing list -- ceph-users-a8pt6IJUokc@public.gmane.org
To unsubscribe send an email to ceph-users-leave-a8pt6IJUokc@public.gmane.org
