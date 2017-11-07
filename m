From: Vasu Kulkarni <vakulkar@redhat.com>
Subject: Re: [ceph-users] removing cluster name support
Date: Tue, 7 Nov 2017 12:33:06 -0800
Message-ID: <CAKPXa=YDxV1G-sgFEsJ9WpUwDn5N0o3eB1=WZKyG3Cr2uTRXWw@mail.gmail.com>
References: <alpine.DEB.2.11.1706081936570.3646@piezo.novalocal>
 <CAJE9aOP99gD3iZbduuRV-nM_fPpNtfW4ah_X11Acag5_a+YTxg@mail.gmail.com>
 <CAC-Np1xa19Q8rYmAvfxZqFDDTWuMqv0GCfDLZBYVg+k15Jvj0w@mail.gmail.com> <alpine.DEB.2.11.1711071931540.29217@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:43719 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752700AbdKGUdH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Nov 2017 15:33:07 -0500
Received: by mail-oi0-f67.google.com with SMTP id c77so400368oig.0
        for <ceph-devel@vger.kernel.org>; Tue, 07 Nov 2017 12:33:07 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1711071931540.29217@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Alfredo Deza <adeza@redhat.com>, kefu chai <tchaikov@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Ceph-User <ceph-users@ceph.com>

On Tue, Nov 7, 2017 at 11:38 AM, Sage Weil <sage@newdream.net> wrote:
> On Tue, 7 Nov 2017, Alfredo Deza wrote:
>> On Tue, Nov 7, 2017 at 7:09 AM, kefu chai <tchaikov@gmail.com> wrote:
>> > On Fri, Jun 9, 2017 at 3:37 AM, Sage Weil <sweil@redhat.com> wrote:
>> >> At CDM yesterday we talked about removing the ability to name your ceph
>> >> clusters.  There are a number of hurtles that make it difficult to fully
>> >> get rid of this functionality, not the least of which is that some
>> >> (many?) deployed clusters make use of it.  We decided that the most we can
>> >> do at this point is remove support for it in ceph-deploy and ceph-ansible
>> >> so that no new clusters or deployed nodes use it.
>> >>
>> >> The first PR in this effort:
>> >>
>> >>         https://github.com/ceph/ceph-deploy/pull/441
>> >
>> > okay, i am closing https://github.com/ceph/ceph/pull/18638 and
>> > http://tracker.ceph.com/issues/3253
>>
>> This brings us to a limbo were we aren't supporting it in some places
>> but we do in some others.
>>
>> It was disabled for ceph-deploy, but ceph-ansible wants to support it
>> still (see:  https://bugzilla.redhat.com/show_bug.cgi?id=1459861 )
>
> I still haven't seen a case where customer server names for *daemons* is
> needed.  Only for client-side $cluster.conf info for connecting.
>
>> Sebastien argues that these reasons are strong enough to keep that support in:
>>
>> - Ceph cluster on demand with containers
>
> With kubernetes, the cluster will existin in a cluster namespace, and
> daemons live in containers, so inside the container hte cluster will be
> 'ceph'.
>
>> - Distributed compute nodes
>
> ?
>
>> - rbd-mirror integration as part of OSPd
>
> This is the client-side $cluster.conf for connecting to the remove
> cluster.
>
>> - Disaster scenario with OpenStack Cinder in OSPd
>
> Ditto.
>
>> The problem is that, as you can see with the ceph-disk PR just closed,
>> there are still other tools that have to implement the juggling of
>> custom cluster names
>> all over the place and they will hit some corner place where the
>> cluster name was not added and things will fail.
>>
>> Just recently ceph-volume hit one of these places:
>> https://bugzilla.redhat.com/show_bug.cgi?id=1507943
>>
>> Are we going to support custom cluster names? In what
>> context/scenarios are we going to allow it?
>
> It seems like we could drop this support in ceph-volume, unless someone
> can present a compelling reason to keep it?
>
> ...
>
> I'd almost want to go a step further and change
>
> /var/lib/ceph/$type/$cluster-$id/
>
> to
>
>  /var/lib/ceph/$type/$id
+1 for custom name support to be disabled from master/stable ansible releases,
And I think rbd-mirror and openstack are mostly configuration issues
that could use different conf files to talk
to different clusters.

>
> In kubernetes, we're planning on bind mounting the host's
> /var/lib/ceph/$namespace/$type/$id to the container's
> /var/lib/ceph/$type/ceph-$id.  It might be a good time to drop some of the
> awkward path names, though.  Or is it useless churn?
>
> sage
>
>
>
>>
>>
>> >
>> >>
>> >> Background:
>> >>
>> >> The cluster name concept was added to allow multiple clusters to have
>> >> daemons coexist on the same host.  At the type it was a hypothetical
>> >> requirement for a user that never actually made use of it, and the
>> >> support is kludgey:
>> >>
>> >>  - default cluster name is 'ceph'
>> >>  - default config is /etc/ceph/$cluster.conf, so that the normal
>> >> 'ceph.conf' still works
>> >>  - daemon data paths include the cluster name,
>> >>      /var/lib/ceph/osd/$cluster-$id
>> >>    which is weird (but mostly people are used to it?)
>> >>  - any cli command you want to touch a non-ceph cluster name
>> >> needs -C $name or --cluster $name passed to it.
>> >>
>> >> Also, as of jewel,
>> >>
>> >>  - systemd only supports a single cluster per host, as defined by $CLUSTER
>> >> in /etc/{sysconfig,default}/ceph
>> >>
>> >> which you'll notice removes support for the original "requirement".
>> >>
>> >> Also note that you can get the same effect by specifying the config path
>> >> explicitly (-c /etc/ceph/foo.conf) along with the various options that
>> >> substitute $cluster in (e.g., osd_data=/var/lib/ceph/osd/$cluster-$id).
>> >>
>> >>
>> >> Crap preventing us from removing this entirely:
>> >>
>> >>  - existing daemon directories for existing clusters
>> >>  - various scripts parse the cluster name out of paths
>> >>
>> >>
>> >> Converting an existing cluster "foo" back to "ceph":
>> >>
>> >>  - rename /etc/ceph/foo.conf -> ceph.conf
>> >>  - rename /var/lib/ceph/*/foo-* -> /var/lib/ceph/*/ceph-*
>> >>  - remove the CLUSTER=foo line in /etc/{default,sysconfig}/ceph
>> >>  - reboot
>> >>
>> >>
>> >> Questions:
>> >>
>> >>  - Does anybody on the list use a non-default cluster name?
>> >>  - If so, do you have a reason not to switch back to 'ceph'?
>> >>
>> >> Thanks!
>> >> sage
>> >> _______________________________________________
>> >> ceph-users mailing list
>> >> ceph-users@lists.ceph.com
>> >> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>> >
>> >
>> >
>> > --
>> > Regards
>> > Kefu Chai
>> > _______________________________________________
>> > ceph-users mailing list
>> > ceph-users@lists.ceph.com
>> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
