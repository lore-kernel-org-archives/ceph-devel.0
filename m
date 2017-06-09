From: Vasu Kulkarni <vakulkar@redhat.com>
Subject: Re: [ceph-users] removing cluster name support
Date: Fri, 9 Jun 2017 08:58:21 -0700
Message-ID: <CAKPXa=ZjsvhAMwdM9k47L4gaMGVispyJ7bMOyR7dVu0y7pb12A@mail.gmail.com>
References: <alpine.DEB.2.11.1706081936570.3646@piezo.novalocal>
 <5BCB72AC-A5E4-4CE3-BF6A-5164F4B64496@quantum.com> <alpine.DEB.2.11.1706081951440.23631@piezo.novalocal>
 <CAC-Np1wjRX99N4q69XfWY0m0fDETpRQZj5Hrgoe6kbrh7riE+A@mail.gmail.com> <CAMrEFZ62a7dToADh=-nbLy15Xx9=_mmJkmDjP-JY4mfarpd_5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33960 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751673AbdFIP6W (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Jun 2017 11:58:22 -0400
Received: by mail-pg0-f44.google.com with SMTP id v18so27878305pgb.1
        for <ceph-devel@vger.kernel.org>; Fri, 09 Jun 2017 08:58:22 -0700 (PDT)
In-Reply-To: <CAMrEFZ62a7dToADh=-nbLy15Xx9=_mmJkmDjP-JY4mfarpd_5Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: wes_dillingham@harvard.edu
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

On Fri, Jun 9, 2017 at 6:11 AM, Wes Dillingham
<wes_dillingham@harvard.edu> wrote:
> Similar to Dan's situation we utilize the --cluster name concept for our
> operations. Primarily for "datamover" nodes which do incremental rbd
> import/export between distinct clusters. This is entirely coordinated by
> utilizing the --cluster option throughout.
>
> The way we set it up is that all clusters are actually named "ceph" on the
> mons and osds etc, but the clients themselves get /etc/ceph/clusterA.conf
> and /etc/ceph/clusterB.conf so that we can differentiate. I would like to
> see the functionality of clients being able to specify which conf file to
> read preserved.

ceph.conf along with keyring file can stay in any location, the
default location is /etc/ceph but one could use
other location for clusterB.conf (
http://docs.ceph.com/docs/jewel/rados/configuration/ceph-conf/ ), At
least
for client which doesn't run any daemon this should be sufficient to
make it talk to different clusters.

>
> As a note though we went the route of naming all clusters "ceph" to
> workaround difficulties in non-standard naming so this issue does need some
> attention.
It would be nice if you can throw in the steps in tracker which can be
then moved to docs so that it can help others follow
those steps to rename the cluster back to 'ceph'


>
> On Fri, Jun 9, 2017 at 8:19 AM, Alfredo Deza <adeza@redhat.com> wrote:
>>
>> On Thu, Jun 8, 2017 at 3:54 PM, Sage Weil <sweil@redhat.com> wrote:
>> > On Thu, 8 Jun 2017, Bassam Tabbara wrote:
>> >> Thanks Sage.
>> >>
>> >> > At CDM yesterday we talked about removing the ability to name your
>> >> > ceph
>> >> > clusters.
>> >>
>> >> Just to be clear, it would still be possible to run multiple ceph
>> >> clusters on the same nodes, right?
>> >
>> > Yes, but you'd need to either (1) use containers (so that different
>> > daemons see a different /etc/ceph/ceph.conf) or (2) modify the systemd
>> > unit files to do... something.
>>
>> In the container case, I need to clarify that ceph-docker deployed
>> with ceph-ansible is not capable of doing this, since
>> the ad-hoc systemd units use the hostname as part of the identifier
>> for the daemon, e.g:
>>
>>     systemctl enable ceph-mon@{{ ansible_hostname }}.service
>>
>>
>> >
>> > This is actually no different from Jewel. It's just that currently you
>> > can
>> > run a single cluster on a host (without containers) but call it 'foo'
>> > and
>> > knock yourself out by passing '--cluster foo' every time you invoke the
>> > CLI.
>> >
>> > I'm guessing you're in the (1) case anyway and this doesn't affect you
>> > at
>> > all :)
>> >
>> > sage
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>
>
>
> --
> Respectfully,
>
> Wes Dillingham
> wes_dillingham@harvard.edu
> Research Computing | Senior CyberInfrastructure Storage Engineer
> Harvard University | 38 Oxford Street, Cambridge, Ma 02138 | Room 102
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
