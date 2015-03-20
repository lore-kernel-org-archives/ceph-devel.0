From: kefu chai <tchaikov@gmail.com>
Subject: Fwd: adding "{mds,mon} metadata" asok command
Date: Fri, 20 Mar 2015 23:58:25 +0800
Message-ID: <CAJE9aOMz+bY_xVQTtSQL08bNBgK77btLDbK9j1sQeQDxF1MtoQ@mail.gmail.com>
References: <CAJE9aOP2g4=Pw-oGY4m90aXayc=Kx_GP8yLC+tTkSE62V6ObuQ@mail.gmail.com>
	<550C07D9.30700@redhat.com>
	<CAJE9aOPK6Qge8BNvB0na2-Y_12THB2aSmk-wvpPytAwcjonMGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:32981 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbbCTP60 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Mar 2015 11:58:26 -0400
Received: by iecvj10 with SMTP id vj10so96378727iec.0
        for <ceph-devel@vger.kernel.org>; Fri, 20 Mar 2015 08:58:25 -0700 (PDT)
In-Reply-To: <CAJE9aOPK6Qge8BNvB0na2-Y_12THB2aSmk-wvpPytAwcjonMGQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Mar 20, 2015 at 7:43 PM, John Spray <john.spray@redhat.com> wrote:
> On 20/03/2015 05:39, kefu chai wrote:
>>
>> to pave the road to http://tracker.ceph.com/issues/10904, where we
>> need to add a command to list the hostname of nodes in a ceph cluster,
>> i would like to add the "{mds,mon} metadata" commands to print the
>> system information including, but not limited to hostname,
>> mem_{total,swap}_kb, and distro info, of specified mds and mon.
>>
>> the implementation follow the mechanism of "osd metadata":
>>
>> on the mds side i would like to reuse the MDSMonitor service:
>> 1. piggy back a map for the metadata in MMDSBeacon message,
>> 2. put the metadata into the same DBStore transaction but with another
>> prefix when storing the pending inc into local storage.
>> 3. and expose it using the "mds metadata" and later on the "service
>> ls" (not sure about the name ...)
>>
>> @greg and @zyan, are you good with this? not sure this will overburden
>> the mds or not. i will use uname(2) and grep /proc/meminfo to get the
>> metadata in the same way of OSD.
>
> It should be straightforward to include the metadata in MMDSBeacon only once
> per daemon lifetime, by checking if state is CEPH_MDS_STATE_BOOT -- that way
> we don't have to worry about any ongoing costs.  I expect that change can

thanks john, it sounds great! and this is a big relief to me.

> live entirely in Beacon.cc without touching any other MDS code.

and MMDSBeacon.{h,cc} and MDSMonitor.{h,cc} for sure, i think. because
we need to put the payload into the message, and put/get the metadata
into the mon's DB storage.

>
> As for the means of getting the information, I expect the generic
> kernel/mem/cpu/distro stuff from OSD::_collect_metadata can be moved up into
> common/ somewhere and reused as-is from mon+mds.

sure, i will refactor the OSD::_collect_metadata() to avoid the copy & paste.

>
> John



--
Regards
Kefu Chai


-- 
Regards
Kefu Chai
