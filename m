From: Sage Weil <sage@newdream.net>
Subject: Re: The stability of MDS
Date: Wed, 27 Apr 2011 09:00:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1104270858300.27415@cobra.newdream.net>
References: <BANLkTik8uQeKVD-h2kQiVkdDc+_pf9PYZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36855 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759306Ab1D0QAo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Apr 2011 12:00:44 -0400
In-Reply-To: <BANLkTik8uQeKVD-h2kQiVkdDc+_pf9PYZQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "doki74216@gmail.com" <doki74216@gmail.com>
Cc: Ceph <ceph-devel@vger.kernel.org>

On Wed, 27 Apr 2011, doki74216@gmail.com wrote:
> Dear developers
> 
> I am testing the reliability of MDS in Ceph File System.
> As we know, the default setting, there are one active MDS and one standby MDS.
> I want to test the reliability of MDS.
> Here is my testing scenario:
> As easy to understand, here I assume the active MDS as mds0 and the
> standby one is mds1.
> I write  data and  stop the mds0 daemon by "ceph mds stop 0" at the same time.
> Will the standby mds1 change its status to active?
> I think the system should be normal and the data should not loss even
> though there is just one MDS.
> But there are many problem I met....><
> 
> (1) I want to know which mds is active and standby.
>      But there are different answer when I type different commands.
> 
> 1. When I type "ceph mds stat".
>     It shows: (0=up: active), 1 up: standby
>                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Does it means mds0

Right, the 0 means mds0.

> is active and mds1 is standby ?
> 2.When I type "ceph mds dump -o -"
>     It shows:  mds0 is standby and mds1 is active.
> 
> My question is: Why there are different status about mds0 and mds1?
> Which one is correct?

It sounds like you named the MDS's with numeric identifiers.  You should 
use non-numeric names to avoid this confusion, like mds.a and mds.b.  The 
numeric role/rank (mds0, mds1) is assigned to cmds instances dynamically 
based on who is up and needed in which role at the time.

> (2) I want to know the issue about stoping the active mds.
>      If the command which  "ceph mds stat" can show the active mds correctly,
>      the active mds must be mds0 and the other mds1 is standby.
>      So I type"ceph mds stop 0".
>      It shows:  ?telling mds0 192.168.200.185:6800/14819 to stop?(0)
>                                                  ^^^^^^^^^^^^^^^^^^ mds1's IP.
> 1. Why it shows the system stoping mds0 but mds1's IP ?

The 'stop' command takes the dynamic role, not the name.

Hope this clears it up!
sage


> 
> 2. When I type "ceph -w", here is the log:
> ======================================
> mds e43: 1/1/1 up {0=up:active}, 1 up standby
> mds e44: 1/1/1 up {0=up:stoping}, 1 up standby
> mds e45: 1/1/1 up {0=up:replay}
> mds e46: 1/1/1 up {0=up:reconnect}
> mds e47: 1/1/1 up {0=up:rejoin}
> mds e44: 1/1/1 up {0=up:active}
> =====================================
> >From the log, which MDS does the system stop?
> My command  which is"ceph mds stop 0", but the log should not be {1=up:active}?
> It really confuse me...
> 
> 3. When I type"ceph mds dump ?o ?", here is the log:
>     4920:   192.168.200.184:6800/30000 ?0? mds0.12 up:active seq 40828
>                  ^^^^^^^^^^^^^^^^^^^ mds0's IP
> Why does the system leave the mds0?
> 
> Please help me solving these problem, I am very confused...
> Thanks a lot~~~^^
> 
> 
> By the way, this is my testing  environment :
> ==================================================================================
> I set 7 servers which include 3 MONs(host1 host2 host3), 2 MDSs(host4
> host5) and 2 OSDes(host6 host7).
> The version ceph 0.26 is in my system.
> ==================================================================================
> --
> Best Regards,
> Stefanie Chen
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
