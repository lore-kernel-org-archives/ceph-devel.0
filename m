From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: An empty vptr in an raw object
Date: Sat, 24 Dec 2016 00:52:12 +0100
Message-ID: <fd2a1413-fbcf-b940-3c07-f57aefc9c300@digiware.nl>
References: <4aeb9ff1-367c-f31e-fc0c-5f08dcdcfe0e@digiware.nl>
 <7754eadf-5f8c-ade3-1634-486fff240adf@digiware.nl>
 <EB02EE10422E4A40A1EE787A4AC27FBE044D2A@ULS-OP-MBXIP02.sdcorp.global.sandisk.com>
 <e1bdab0b-ec02-819e-e6fe-4e07baa235be@digiware.nl>
 <EB02EE10422E4A40A1EE787A4AC27FBE045604@ULS-OP-MBXIP02.sdcorp.global.sandisk.com>
 <dd12b176-2294-72cd-c2b7-6fff709d44c6@digiware.nl>
 <alpine.DEB.2.11.1612231418570.10615@piezo.novalocal>
 <5eda2374-c9a8-a8c6-e925-c87320a326c4@digiware.nl>
 <alpine.DEB.2.11.1612231643450.10615@piezo.novalocal>
 <4a510a2f-1079-07d6-778c-90769f6434db@digiware.nl>
 <alpine.DEB.2.11.1612231659070.10615@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:10287 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753822AbcLXAAF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 23 Dec 2016 19:00:05 -0500
In-Reply-To: <alpine.DEB.2.11.1612231659070.10615@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 23-12-2016 17:59, Sage Weil wrote:

> I mean s/sizeof(T) * 3/s/.
> 
> It makes sense that sizeof(std::string)*3 is unrelated to the encoded 
> size.

PR submitted as: #12653

--WjW


