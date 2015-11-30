From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Compiling for FreeBSD
Date: Mon, 30 Nov 2015 12:53:54 +0100
Message-ID: <565C38D2.4080403@digiware.nl>
References: <565B3999.3050302@digiware.nl>
 <CACJqLyaSTqKjAQf1Nb8UE00SrF0y1fskYhExmWd3vbCvNrFBkA@mail.gmail.com>
 <565B4A7F.60301@digiware.nl>
 <CAAM7YAmmOwfyiB1jFfGLz4fDxPxHRPQQNk80qEq2-RqFiHH-3g@mail.gmail.com>
 <20151130065812.GA20205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:54862 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753321AbbK3Ly0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 30 Nov 2015 06:54:26 -0500
In-Reply-To: <20151130065812.GA20205@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <mgolub@mirantis.com>, "Yan, Zheng" <ukernel@gmail.com>
Cc: Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 30-11-2015 07:58, Mykola Golub wrote:
> On Mon, Nov 30, 2015 at 11:46:27AM +0800, Yan, Zheng wrote:
>> On Mon, Nov 30, 2015 at 2:57 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
...

Hi Mykola,

> I have a branch in my repo that contains patches to make compilation
> on FreeBSD easier:
> 
> https://github.com/trociny/ceph/commits/wip-freebsd

Right, I'll and see what you've all got worked out.
First get done with my daytime job that pays the rent.


> The branch have not been rebased against master since March though,
> still I hope to find time in future to update and pull some bits
> upstream.
> 
> Particularly, this patch contains packages dependencies list:
> 
> https://github.com/trociny/ceph/commit/2307706461ae09922c087065a8b50a04a61159b1

Right, I had most of those already figured out, but some much less obvious.

And the humor is on the first line... bash <> sh.
In just about all linux oriented software that is one of the things to
start with. FreePBX is also loaded with those.

I've sort of given up on this one, resistance is futile.
And I install bash in /bin.

> And this one configuration options I used
> 
> https://github.com/trociny/ceph/commit/dcee0c0635d37f2b36257c55a3cc69d05b5afe5e
>
> I have seen several commits since that time in master aimed to improve
> FreeBSD compilation, so I suppose some of my patches are not needed
> any more.
> 
> Still, if you experince issues building upstream Ceph on FreeBSD, and
> just want to try it on FreeBSD, you could try my branch:
> 
> git clone --recursive -b wip-freebsd https://github.com/trociny/ceph.git
> cd ceph
> ./install-deps.sh
> ./do_autogen.sh
> gmake
> cd src
> ./vstart.sh # start dev cluster
> ./ceph -s # check it works
> 

So what backend for the OSDs are you using here?

--WjW

