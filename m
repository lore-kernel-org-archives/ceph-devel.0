From: Wido den Hollander <wido@42on.com>
Subject: Re: RHEL 6.5 shared library upgrade safety
Date: Mon, 18 Aug 2014 14:11:00 +0200
Message-ID: <53F1ED54.2020109@42on.com>
References: <53F1EA1C.1020108@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:49349 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751118AbaHRMLD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 18 Aug 2014 08:11:03 -0400
In-Reply-To: <53F1EA1C.1020108@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

On 08/18/2014 01:57 PM, Loic Dachary wrote:
> Hi Ceph,
>
> In RHEL 6.5, is the following scenario possible :
>
> a) an OSD dlopen a shared library for erasure-code,
> b) the shared library file is replaced while the OSD is running,
> c) the OSD starts using the new file instead of the old one.
>
> It seems unlikely but it would explain a weird stack trace at http://tracker.ceph.com/issues/9153#note-5 so I'm double checking ;-)
>

Well, it could be that it does so. I'm not 100% sure, but afaik it could 
happen that when you replace a library certain parts might not be in memory.

See: 
http://stackoverflow.com/questions/7767325/replacing-shared-object-so-file-while-main-program-is-running

> Cheers
>


-- 
Wido den Hollander
Ceph consultant and trainer
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
