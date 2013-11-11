From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: Mourning the demise of mkcephfs
Date: Tue, 12 Nov 2013 09:37:17 +1300
Message-ID: <52813FFD.3000508@catalyst.net.nz>
References: <5281192D.4090707@bob-the-boat.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:35513 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472Ab3KKUhX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Nov 2013 15:37:23 -0500
In-Reply-To: <5281192D.4090707@bob-the-boat.me.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Dave (Bob)" <dave@bob-the-boat.me.uk>, ceph-devel@vger.kernel.org

Hi,

Loic posted a script he uses for testing setups without ceph-deploy:

http://www.spinics.net/lists/ceph-devel/msg16895.html
http://dachary.org/wp-uploads/2013/10/micro-osd.txt

it probably has enough steps in it for you to adapt.

Regards

Mark

P.s: what *is* your platform? It might not be too hard to get 
ceph-deploy going on it :-)

On 12/11/13 06:51, Dave (Bob) wrote:
> The utility mkcephfs seemed to work, it was very simple to use and
> apparently effective.
>
> It has been deprecated in favour of something called ceph-deploy, which
> does not work for me.
>
> I've ignored the deprecation messages until now, but in going from 70 to
> 72 I find that mkcephfs has finally gone.
>
> I have tried ceph-deploy, and it seems to be tied in to specific
> 'distributions' in some way.
>
> It is unuseable for me at present, because it reports:
>
> [ceph_deploy][ERROR ] UnsupportedPlatform: Platform is not supported:
>
>
> I therefore need to go back to first principles, but the documentation
> seems to have dropped descriptions of driving ceph without smoke and
> mirrors.
>
> The direct approach may be more laborious, but at least it would not
> depend on anything except ceph itself.
>
> Maybe I need to step back a version or two, set up my cluster with
> mkcephfs, then switch back to the latest to use it.
>
> I'll search the documentation again.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

