From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: Infiniband 40GB
Date: Mon, 04 Jun 2012 17:42:05 +0200
Message-ID: <4FCCD74D.2030309@profihost.ag>
References: <4FCB1C0A.4050504@profihost.ag> <CADdPHGvgE7ai6yjzsKmL9bfqEpyx+qxQaUKoOOYjiT4ZCJ-A0g@mail.gmail.com> <4FCC7E34.7040005@univ-nantes.fr> <201206041147.22993.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:54222 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176Ab2FDPmI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jun 2012 11:42:08 -0400
In-Reply-To: <201206041147.22993.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: Yann Dupont <Yann.Dupont@univ-nantes.fr>, ceph-devel@vger.kernel.org

Hi Amon,

thanks for your backported patch. At least it doesn't cleanly apply to 
debian squeeze stable as it wants a glic 2.12 in Versions.def but Debian 
is only at 2.11? Do you use another patch too?

Stefan
