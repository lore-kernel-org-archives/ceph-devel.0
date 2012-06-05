From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: Infiniband 40GB
Date: Tue, 05 Jun 2012 09:46:37 +0200
Message-ID: <4FCDB95D.6060804@profihost.ag>
References: <4FCB1C0A.4050504@profihost.ag> <201206041147.22993.a.ott@m-privacy.de> <4FCCD74D.2030309@profihost.ag> <201206050908.22970.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:38672 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756843Ab2FEHqi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Jun 2012 03:46:38 -0400
In-Reply-To: <201206050908.22970.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: Yann Dupont <Yann.Dupont@univ-nantes.fr>, ceph-devel@vger.kernel.org

Am 05.06.2012 09:08, schrieb Amon Ott:
> On Monday 04 June 2012 wrote Stefan Priebe:
>> Hi Amon,
>>
>> thanks for your backported patch. At least it doesn't cleanly apply to
>> debian squeeze stable as it wants a glic 2.12 in Versions.def but Debian
>> is only at 2.11? Do you use another patch too?
>
> I ripped the patch right out of our previously built 2.11.3-3 source tree. It
> needs to be last in the series file, because several existing Debian patches
> modify the sources at various places. I could also make our compiled packages
> available to you for download.

Sorry i added the file in front of the series file...

Thanks
Stefan
