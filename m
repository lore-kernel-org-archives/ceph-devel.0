From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Extra daemons/servers reporting to mgr
Date: Wed, 14 Jun 2017 10:43:41 -0700
Message-ID: <CAJ4mKGbW0bQ=X6Mp1iDCE-ekme38nhi0srMnz0F7uquedZbfKQ@mail.gmail.com>
References: <CALe9h7eT+7KUt7VZPaYfR49FEPP3mJbe2+ARK82BaZUMmStchw@mail.gmail.com>
 <73f90019-71aa-2cf1-92e8-0ba7087d62a4@redhat.com> <CALe9h7dH=BDZUacnymZ3QbYqJEAiAVkDavKK2rTnNH+CmEO+aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:33442 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751816AbdFNRnq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Jun 2017 13:43:46 -0400
Received: by mail-io0-f178.google.com with SMTP id t87so5022680ioe.0
        for <ceph-devel@vger.kernel.org>; Wed, 14 Jun 2017 10:43:46 -0700 (PDT)
In-Reply-To: <CALe9h7dH=BDZUacnymZ3QbYqJEAiAVkDavKK2rTnNH+CmEO+aQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Casey Bodley <cbodley@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jun 12, 2017 at 1:33 PM, John Spray <jspray@redhat.com> wrote:
> On Mon, Jun 12, 2017 at 2:09 PM, Casey Bodley <cbodley@redhat.com> wrote:
>>
>> On 06/11/2017 08:04 AM, John Spray wrote:
>>>
>>> MgrClient instances (such as those in the daemons, and those in every
>>> librados instance) open a session with ceph-mgr where they identify
>>> themselves by entity name and type.  ceph-mgr sends a MgrConfigure
>>> message, which tells the client whether to both sending stats and how
>>> often.  ceph-mgr also keeps a copy of the metadata (a la "ceph osd
>>> metadata...") for OSD and MDS daemons -- it loads all that up at
>>> startup, and then also freshens it when it sees a daemon restart or
>>> sees a new daemon.
>>>
>>> We would like to have something similar so that the mgr can be aware
>>> of the existence of other services like RGW gateways, RBD mirror
>>> services, perhaps also NFS gateways.
>>>
>>> The information about each daemon would at a minimum be its identity,
>>> type, and some static metadata.  It might also include some dynamic
>>> state/health structure.  The challenging part here is how to expose
>>> that to the various daemons, given that things like RGW are not known
>>> in advance to core Ceph and that they just consume the librados
>>> interface.
>>>
>>> It doesn't feel like a particularly natural thing for librados, but
>>> ultimately whatever we expose to rgw/rbd is de-facto librados, even if
>>> we put it in a different library or whatever.
>>>
>>> So far I've got as far as thinking we should have an extra call just
>>> in the C++ bindings that lets callers say "Hi, I'm a service not just
>>> a client, and here's a map of metadata", that they call one time
>>> between creating their RadosClient and connecting to the cluster.
>>>
>>> John
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>> Hi John,
>>
>> Is there a reason that radosgw can't instantiate its own MgrClient instance
>> and report status through that, instead of having to go through librados? If
>> we have to report an entity instance, we could choose from one of our Rados
>> clients.
>
> Currently librados does internally have a MgrClient already, so I
> think I was instinctively looking to reuse that.
>
> However, the MgrClient in librados is only there so that it can issue
> commands (i.e. for use in CLI), so one option would be to disable that
> MgrClient by default (unless someone is actually calling
> mgr_command()), and instantiate an external one.
>
> For things like NFS-ganesha though, we can't use MgrClient unless we
> formalize it as an external API...

Perhaps somebody can draw up what data we actually want to share from
NFS-Ganesha to the manager? (Or from RGW?)

It's not unreasonable to let RGW set up its own MgrClient, since it's
an in-tree service and can be kept more tightly bound than external
librados users. But if we can make a simple interface that serves both
needs, that would be better. Maybe something like
void share_metadata(map<string,string>);
that can be invoked whenever desired, and the MgrClient sends that in
whenever it's doing a report? Or maybe we want something that more
explicitly maps from static metadata (like kind and version info)
versus perfcounter-like state.

But I'm not sure we actually want to restrict shared data to going in
via services. It seems perfectly reasonable to collect IO and other
statistics from cooperating clients, if we can do that without
overwhelming the manager service.
-Greg
