From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Compiling for FreeBSD
Date: Sun, 29 Nov 2015 19:57:03 +0100
Message-ID: <565B4A7F.60301@digiware.nl>
References: <565B3999.3050302@digiware.nl>
 <CACJqLyaSTqKjAQf1Nb8UE00SrF0y1fskYhExmWd3vbCvNrFBkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:13974 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751180AbbK2S5P (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 29 Nov 2015 13:57:15 -0500
In-Reply-To: <CACJqLyaSTqKjAQf1Nb8UE00SrF0y1fskYhExmWd3vbCvNrFBkA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 29-11-2015 19:08, Haomai Wang wrote:

> I guess we still expect FreeBSD support, which version do you test to
> compile? I'd like to help to make bsd work :-)

I considered it is best to develop against HEAD aka:
11.0-CURRENT FreeBSD 11.0-CURRENT #0 r291381: Sat Nov 28 14:22:54 CET 2015
I'm also training configure the use as much of CLANG as possible.

I would guess that by the time we get anything worth mentioning 11.0
will be released of close to release.
Note that the release date for 11.0 is july 2016

--WjW


