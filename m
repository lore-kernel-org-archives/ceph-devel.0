From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Compiling for FreeBSD
Date: Mon, 30 Nov 2015 15:40:56 +0100
Message-ID: <565C5FF8.1090003@digiware.nl>
References: <565B3999.3050302@digiware.nl>
 <CACJqLyaSTqKjAQf1Nb8UE00SrF0y1fskYhExmWd3vbCvNrFBkA@mail.gmail.com>
 <565B4A7F.60301@digiware.nl>
 <CAAM7YAmmOwfyiB1jFfGLz4fDxPxHRPQQNk80qEq2-RqFiHH-3g@mail.gmail.com>
 <20151130065812.GA20205@gmail.com> <565C38D2.4080403@digiware.nl>
 <20151130141320.GB20205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:37594 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753699AbbK3Ola (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 30 Nov 2015 09:41:30 -0500
In-Reply-To: <20151130141320.GB20205@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <mgolub@mirantis.com>
Cc: "Yan, Zheng" <ukernel@gmail.com>, Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 30-11-2015 15:13, Mykola Golub wrote:
> On Mon, Nov 30, 2015 at 12:53:54PM +0100, Willem Jan Withagen wrote:
> 
>>> git clone --recursive -b wip-freebsd https://github.com/trociny/ceph.git
>>> cd ceph
>>> ./install-deps.sh
>>> ./do_autogen.sh
>>> gmake
>>> cd src
>>> ./vstart.sh # start dev cluster
>>> ./ceph -s # check it works
>>>
>>
>> So what backend for the OSDs are you using here?
> 
> The default one, which is FileStore. I have not done much testing
> though...
> 

Well,
Cherry-picked a few of you diffs.
Compilation is now slugging thru the tests in my tree.
Running gmake in serial mode, so it is slow with clang.

--WjW


