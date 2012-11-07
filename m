From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Ubuntu 12.04.1 + xfs + syncfs is still not our friend
Date: Wed, 07 Nov 2012 11:03:11 -0800
Message-ID: <509AB06F.7030406@inktank.com>
References: <50993755.8060800@filoo.de> <50993B61.3090500@filoo.de> <50999AD2.8030507@inktank.com> <CAJH6TXh3f+-qcz_p80y_7Lwj1m9wan7aLvY90VdS3ypsxix4pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:37694 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306Ab2KGTDe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Nov 2012 14:03:34 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so810981dak.19
        for <ceph-devel@vger.kernel.org>; Wed, 07 Nov 2012 11:03:34 -0800 (PST)
In-Reply-To: <CAJH6TXh3f+-qcz_p80y_7Lwj1m9wan7aLvY90VdS3ypsxix4pQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Dan Mick <dan.mick@inktank.com>, Oliver Francke <Oliver.Francke@filoo.de>, ceph-devel@vger.kernel.org

On 11/07/2012 12:14 AM, Gandalf Corvotempesta wrote:
> 2012/11/7 Dan Mick <dan.mick@inktank.com>:
>> Resolution: installing the packages built for precise, rather than squeeze,
>> got versions that use syncfs.
>
> Which packages, ceph or libc?

The ceph packages.
