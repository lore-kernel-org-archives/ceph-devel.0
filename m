From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: host settings in ceph.conf when ipaddress != hostname
Date: Thu, 16 Aug 2012 22:38:17 -0400
Message-ID: <CACkq2mp5p0x_J4PTj09Ma0Qgui-z_CXGkThLVZ8DaPT=-xOPdA@mail.gmail.com>
References: <CACkq2moqr-VpwLpG2xcTvUfJ4Xm0EKazis4pW_M4FLuATqOHVg@mail.gmail.com>
 <CADvuQRFZRwL4oBvJW2H25VFME3pTk4rDZxr4WzwMT=sp-K8h6g@mail.gmail.com>
 <502D51D4.5010606@smart-weblications.de> <CACkq2mqjp-bgQ1XpdB1b7ApRRV_GtKivf_D9Tj9CXO==rFg4nA@mail.gmail.com>
 <CADvuQRE0wK+avi0wZ_Jko+idLiShz7n8KKPn0nzTc12vMzGuUw@mail.gmail.com> <CACkq2mpLCLU=WZcW_G84wxopmgBzwhFLdJqSm4kDM50rYvRFyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:34918 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754506Ab2HQCij (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Aug 2012 22:38:39 -0400
Received: by qcro28 with SMTP id o28so2731408qcr.19
        for <ceph-devel@vger.kernel.org>; Thu, 16 Aug 2012 19:38:37 -0700 (PDT)
In-Reply-To: <CACkq2mpLCLU=WZcW_G84wxopmgBzwhFLdJqSm4kDM50rYvRFyQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: John Wilkins <john.wilkins@inktank.com>, Smart Weblications GmbH <info@smart-weblications.de>, ceph-devel@vger.kernel.org

Tommi,

Thanks again for your help earlier.  setting the cluster and public
CIDRs in the config file worked very well.

However, the output of "service ceph -a status" still was giving me output like:

root@ceph0:~# /etc/init.d/ceph -a status mon
=== mon.a ===
mon.a: running 0.48.1argonaut
=== mon.b ===
mon.b: running unknown
=== mon.c ===
mon.c: running unknown

I was surprised by this, because the hostname problem was no longer an
issue.  I ran the script with "bash -x", and saw this:

++ /usr/bin/ceph-conf -c /etc/ceph/ceph.conf -n mon.b 'admin socket'
++ eval echo -n /var/run/ceph/ceph-mon.b.asok
+++ echo -n /var/run/ceph/ceph-mon.b.asok
+ eval 'asok="/var/run/ceph/ceph-mon.b.asok"'
++ asok=/var/run/ceph/ceph-mon.b.asok
++ /usr/bin/ceph --admin-daemon /var/run/ceph/ceph-mon.b.asok version
++ echo unknown
+ version=unknown
+ echo 'mon.b: running unknown'
mon.b: running unknown

That made me try this:

root@ceph0:~# ssh ceph1 /usr/bin/ceph --admin-daemon
/var/run/ceph/ceph-mon.b.asok version
0.48.1argonaut

Which, as you can see, returns the version just fine.  So, I noticed
the problem was that the script was not using SSH for getting the
version from remote hosts.

I'm not sure if other people have seen this or not. I was able to
modify the code to make things work.  I'm sending a patch shortly.
Hopefully I did things correctly, and this is indeed something that
needs to be fixed (rather than something just being wrong in my
setup).

After the patch, I see nice output:

root@ceph0:~# /etc/init.d/ceph -a status
=== mon.a ===
mon.a: running 0.48.1argonaut
=== mon.b ===
mon.b: running 0.48.1argonaut
=== mon.c ===
mon.c: running 0.48.1argonaut



On Thu, Aug 16, 2012 at 4:26 PM, Travis Rhoden <trhoden@gmail.com> wrote:
> Tommi,
>
> Thanks, I'm beginning to understand.  I think the only piece I'm
> missing (or rather, that I didn't understand before) is that if I use
> the options for cluster_network and private_network in [global] then
> the OSDs and MONs will automatically bind to the IP address/interface
> that matches that CIDR when they start up?  Thereby negating my having
> to put a specific addr in each [osd.x] or [mon.x] section.  Do I
> understand that correctly?
>
> If I do, then your initial suggestion of setting those fields is
> exactly what I want.
>
>  - Travis
>
> On Thu, Aug 16, 2012 at 4:22 PM, Tommi Virtanen <tv@inktank.com> wrote:
>> On Thu, Aug 16, 2012 at 1:13 PM, Travis Rhoden <trhoden@gmail.com> wrote:
>>> Is there a link to the docs where the config file options for
>>> public_network, cluster_network, mon host, cluster addr are listed and
>>> explained?  I looked for them, but couldn't find anything. I just come
>>> across different mailing list entries and blog entries that keep using
>>> options I've never seen before.  I expected to find these options
>>> here: http://ceph.com/docs/master/config-cluster/ceph-conf/  but no
>>> luck.
>>
>> Yeah those don't seem to be well documented.
>>
>> The only doc mentions of the config options are in:
>> http://ceph.com/docs/master/ops/manage/grow/mon/
>> http://ceph.com/docs/master/man/8/ceph-mon/
>> http://ceph.com/docs/master/dev/mon-bootstrap/
>>
>>> Looking at a blog post like this:
>>> http://www.sebastien-han.fr/blog/2012/07/29/tip-ceph-public-slash-private-network-configuration/,
>>> I become more confused.  Obviously I don't understand the relationship
>>> between OSD and MONs correctly.  If I place all my OSDs on a private
>>> network and the MONs on a public one, how do clients reach the OSDs?
>>> I didn't think that data was funneled through the MONs.  Is that
>>> incorrect?  I thought my OSDs had to be reachable by anyone trying to
>>> mount/map an RBD, for example.
>>
>> That setup is used with multihomed hosts. Two network interfaces, with
>> often the "cluster" one being significantly faster (replication causes
>> write amplification). Clients talk to mons and osds via the public
>> network, osd<->osd traffic is on the cluster network.
