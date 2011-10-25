From: Sage Weil <sage@newdream.net>
Subject: Re: PG stuck in scrubbing
Date: Tue, 25 Oct 2011 09:11:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1110250909040.20108@cobra.newdream.net>
References: <CAO47_-_N3iP0ShdPi0Q_KcX80P=CU3bJz14uuxjCaWgotKNDdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53499 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438Ab1JYQL5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Oct 2011 12:11:57 -0400
In-Reply-To: <CAO47_-_N3iP0ShdPi0Q_KcX80P=CU3bJz14uuxjCaWgotKNDdA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

On Tue, 25 Oct 2011, Christian Brunner wrote:
> Here is another problem I've seen. Unfortunatly I do not have any
> debug output and it's not reproduceable.
> 
> While removing an image with "rbd rm" I noticed that rbd stopped
> making progress. When I looked with "ceph -w" I saw a PG, that was in
> state "active+clean+scrubbing":
> 
> 2011-10-25 14:01:34.198961    pg v1215175: 2776 pgs: 2775
> active+clean, 1 active+clean+scrubbing; 3000 GB data, 1658 GB used,
> 56737 GB / 59615 GB avail

I hit this a few days ago and wasn't able to pinpoint the cause, but 
did simplify the surrounding code and haven't hit it since.  There have 
also been several fixes surrounding the op requeuing.  We haven't run the 
full battery of tests yet, but in another day or two master should behave 
much better.

FWIW, the scrub patch was dd5087fabb2a743741a96ee4610379afa8431f68.

sage



> 
> This state didn't change for half an hour, so I decided to look which
> OSD is involved
> 
> pg_stat objects mip     degr    unf     kb      bytes   log
> disklog state   v       reported        up      acting  last_scrub
> 2.163   773     0       0       0       3162113 3238002800      1917
>  1917    active+clean+scrubbing  2626'7909       2597'10775
> [11,7]       [11,7]  2613'7708       2011-10-24 11:54:39.890963
> 
> and I restared OSD 11. After that everything went back to normal - the
> "rbd rm" finished and scrubbing continued on other PGs. Doing a manual
> scrub on 2.163 is fine, too.
> 
> Regards,
> Christian
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
