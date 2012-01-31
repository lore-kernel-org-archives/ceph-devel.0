From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Ceph behavior in case of network failure
Date: Tue, 31 Jan 2012 10:29:15 -0800
Message-ID: <CAF3hT9Afey7uMvQV7M__hr+aO241ViY05hJiFfwV+H4O7-gZmA@mail.gmail.com>
References: <loom.20120129T054836-318@post.gmane.org>
	<CAF3hT9A6JZPUdWxbeixdpbCQEuEZfDLzD4EvjASG0+6U3EV_Eg@mail.gmail.com>
	<loom.20120131T060749-554@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40083 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753505Ab2AaS3Q convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Jan 2012 13:29:16 -0500
Received: by iacb35 with SMTP id b35so296546iac.19
        for <ceph-devel@vger.kernel.org>; Tue, 31 Jan 2012 10:29:15 -0800 (PST)
In-Reply-To: <loom.20120131T060749-554@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: madhusudhan <madhusudhana.u.acharya@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Jan 30, 2012 at 9:13 PM, madhusudhan
<madhusudhana.u.acharya@gmail.com> wrote:
> Gregory Farnum <gregory.farnum <at> dreamhost.com> writes:
>
>>
>> On Sat, Jan 28, 2012 at 8:52 PM, Madhusudhan
>> <madhusudhana.u.acharya <at> gmail.com> wrote:
>> > I have configured ceph in centos5.6 after a
>> > very long fight. Now, i am in the way
>> > to evaluate the Ceph. Forget me if my
>> > question looks amateur. If we consider a
>> > situation where my core switch fails,
>> > resulting in n/w failure in entire data
>> > center. What happens to ceph cluster ?
>> > will it sustain this n/w failure and comes
>> > online when the n/w is restored ?
>>
>> Hmmm. If your network breaks horribly, you will probably need to
>> restart the daemons =97=A0once their communication breaks they'll st=
art
>> marking each other down and the monitors will probably accept those
>> reports once the network starts working again. (Actually, maybe we
>> should update that so the monitors reject sufficiently old reports.)
>> But it will be a transient effect; restarting your machines will be
>> enough to restore service. :)
>> -Greg
>>
> Thank you Greg for the reply. Do we have to start both osd/mon
> deamons on all the nodes ? I one of the case, i rebooted my
> osd node (when it wan running to check the fault tolerance)
> and when it came online, its journal got corrupted. I had to
> reinitialize the node by erasing all data in it. And rebooting
> =A0the entire cluster (in case of n/w failure) doesn't seems to
> =A0be a good idea for me as clients will start mounting the
> cluster immediately and start writing or reading
> from the cluster.

Hmm, actually I checked with some coworkers and you shouldn't need to
restart anything at all =97=A0the OSDs will correct the report themselv=
es.
So it should all be good! You'll likely experience some slowness while
the OSD states flap (up and down), but it will all be transparent to
the clients.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
