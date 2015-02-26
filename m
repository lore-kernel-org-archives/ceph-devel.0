From: John Spray <john.spray@redhat.com>
Subject: Re: MDS crashes (80.8)
Date: Thu, 26 Feb 2015 17:50:40 +0000
Message-ID: <54EF5CF0.3030503@redhat.com>
References: <CAGbvivJQYb6KpZPW0ug_q7rbL_NYB2eGS+Vcktvy_W3ECHxKbA@mail.gmail.com>	<54EF527B.8060403@redhat.com> <CAGbvivK+oHAfD3bURzDyRDsoBtKtmp35ZZ-YC7kLyLXD6mQ6fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53104 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752971AbbBZRun (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 Feb 2015 12:50:43 -0500
In-Reply-To: <CAGbvivK+oHAfD3bURzDyRDsoBtKtmp35ZZ-YC7kLyLXD6mQ6fQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Cc: ceph-devel@vger.kernel.org

On 26/02/2015 17:19, Wyllys Ingersoll wrote:
> OK, attached is the initial log, or at least the earliest log I can find.
>
Ah, now that I look more closely at the backtrace, I realise that 
creation succeeded, but it is now failing on subsequent runs because it 
can't find the metadata pool.  I guess you probably deleted it at some 
point between Monday and today.  You will need to create yourself some 
filesystem pools (metadata and data) before using newfs to reset your 
filesystem.

Cheers,
John
