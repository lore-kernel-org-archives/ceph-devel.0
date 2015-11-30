From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Compiling for FreeBSD
Date: Mon, 30 Nov 2015 15:56:28 +0100
Message-ID: <565C639C.1080009@digiware.nl>
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
Received: from smtp.digiware.nl ([31.223.170.169]:62627 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754071AbbK3O4l (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 30 Nov 2015 09:56:41 -0500
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

Seems we have passed the first hurdle...
It compiles...

Onto the next phase: Testing.
Lets see what the developers site has to tell about that.

--WjW

chmod +x ceph-coverage.tmp
chmod a-w ceph-coverage.tmp
mv ceph-coverage.tmp ceph-coverage
cd ./ceph-detect-init ; python setup.py build
running build
running build_py
gmake[3]: Leaving directory '/usr/srcs/Ceph/src/ceph/src'
gmake[2]: Leaving directory '/usr/srcs/Ceph/src/ceph/src'
gmake[1]: Leaving directory '/usr/srcs/Ceph/src/ceph/src'
Making all in man
gmake[1]: Entering directory '/usr/srcs/Ceph/src/ceph/man'
gmake[1]: Nothing to be done for 'all'.
gmake[1]: Leaving directory '/usr/srcs/Ceph/src/ceph/man'
Making all in doc
gmake[1]: Entering directory '/usr/srcs/Ceph/src/ceph/doc'
gmake[1]: Nothing to be done for 'all'.
gmake[1]: Leaving directory '/usr/srcs/Ceph/src/ceph/doc'
Making all in systemd
gmake[1]: Entering directory '/usr/srcs/Ceph/src/ceph/systemd'
gmake[1]: Nothing to be done for 'all'.
gmake[1]: Leaving directory '/usr/srcs/Ceph/src/ceph/systemd'
Making all in selinux
gmake[1]: Entering directory '/usr/srcs/Ceph/src/ceph/selinux'
gmake[1]: Nothing to be done for 'all'.
gmake[1]: Leaving directory '/usr/srcs/Ceph/src/ceph/selinux'

