From: Florian Haas <florian@hastexo.com>
Subject: Re: [PATCH 0/2] Add Ceph integration with OCF-compliant HA resource managers
Date: Fri, 6 Jan 2012 20:00:51 +0100
Message-ID: <CAPUexz8+300nFSYT8MgUVATeyJfaPWXLujj+Cwi73yYfOHjyXA@mail.gmail.com>
References: <1325188682-9518-1-git-send-email-florian@hastexo.com>
	<1392105.DlScea8uhi@mranderson>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50866 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756639Ab2AFTAw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jan 2012 14:00:52 -0500
Received: by qats34 with SMTP id s34so892195qat.19
        for <ceph-devel@vger.kernel.org>; Fri, 06 Jan 2012 11:00:51 -0800 (PST)
In-Reply-To: <1392105.DlScea8uhi@mranderson>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Szabolcs,

2012/1/6 Sz=C3=A9kelyi Szabolcs <szekelyi@niif.hu>:
> On 2011. December 29. 20:58:00 Florian Haas wrote:
>> please consider reviewing the following patches. These add
>> OCF-compliant cluster resource agent functionality to Ceph, allowing
>> MDS, OSD and MON to run as cluster resources under compliant manager=
s
>> (such as Pacemaker, http://www.clusterlabs.org).
>
> Nice work, however, I don't really see the point of running Ceph in a=
 HA
> cluster. If you have more than one machine, then why not deploy Ceph =
as an
> active-active (Ceph) cluster? If you want an active-backup cluster, t=
hen why
> use Ceph?

What makes you think that Pacemaker doesn't support active/active?

> There might be situations however, where this feature can come handy,=
 although
> I can't think of any right now. Can you sketch up one?

As far as I'm informed, there's currently no "official" method of
recovering Ceph daemons in place when they die. And I suppose (correct
me if I'm wrong) that there would be two ways of achieving that.

1. systemd integration. systemd, via Restart=3Don-failure (or maybe eve=
n
Restart=3Dalways) in a .service definition, could recover a failed
daemon. As far as I can see, such service definitions don't exist for
any of the ceph daemons, and systemd is not exactly my home turf, so I
can't really contribute to ceph/systemd integration. That being said,
systemd is currently far from ubiquitous on most platforms, and
specifically in the Debian/Ubuntu corner I wonder if we're going to
see widespread systemd integration anytime soon. (It still would be
cool to have, needless to say.)

2. Pacemaker integration. Pacemaker has the ability of recovering
daemons in-place via its monitor operations and automatic resource
recovery, and has no systemd dependency (it doesn't need to interface
with any of the init daemons for resource management, really).
Pacemaker is available across all Linux distros, today.

Pacemaker integration has an added benefit: since Pacemaker is aware
of the services in a cluster, we can always tell the cluster, i want
this many mon instances, or this many OSDs, and Pacemaker can ensure
exactly that. Pacemaker is also unique among cluster managers that it
supports clones, a configuration facility that comes in very handy for
Ceph daemon management.

Pacemaker (or more specifically its underlying
communications/messaging layer) is, obviously, not without
limitations. Specifically, most people deploy clusters of less than 10
nodes in size, with 32 nodes in one cluster membership being the
current maximum that any QA/QE organization frequently tests for
reliability. But still, say a 20-node Pacemaker cluster, where 8 nodes
hold RADOS storage and the other 12 are hypervisor hosts consuming the
storage via libvirt/RBD -- such a thing can still manage an ample
number of Terabytes worth of storage, and host a pretty large array of
virtual machines, don't you think?

Cheers,
=46lorian
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
