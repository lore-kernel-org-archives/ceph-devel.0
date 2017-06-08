From: Loic Dachary <loic@dachary.org>
Subject: Re: run-tox-ceph-disk
Date: Thu, 8 Jun 2017 13:12:42 +0200
Message-ID: <4334e173-002d-7785-8aa2-186913773d4e@dachary.org>
References: <062dfae7-eb33-9eb3-b2ad-34497bc0c1c2@redhat.com>
 <e7901bfc-9e21-e226-fa6c-eabfee817ce8@dachary.org>
 <CALBbquH=BWGej5OKj0cQT=0Pa+e5jM5sJ7Ji5zoT6tyzkqrUrQ@mail.gmail.com>
 <2661a852-65a9-05e3-a621-81cbda974a2d@dachary.org>
 <eacabba5-899e-6a28-b871-d1d6063d49a9@redhat.com>
 <3a4cc839-97c9-bb08-b946-a07da30d6b04@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:37934 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750788AbdFHLMq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Jun 2017 07:12:46 -0400
In-Reply-To: <3a4cc839-97c9-bb08-b946-a07da30d6b04@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jos Collin <jcollin@redhat.com>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

Yes, that's hopefully good enough. The real solution would be for the ceph CLI to be a python module with dependencies in a requirements.txt file, but that would be more complicated ;-)

On 06/08/2017 01:08 PM, Jos Collin wrote:
> Looks like it is already fixed:
> 
> commit 91d36b64f3a1000e38aa620cddfdf3fe1866ad85
> Author: Willem Jan Withagen <wjw@digiware.nl>
> Date:   Fri Jun 2 16:53:43 2017 +0200
> 
>     ceph-disk: use system modules if needed
> 
>      - prettytable usage was introduced in:
>             https://github.com/ceph/ceph/commit/3fa8bb1
>        It is in the install-deps.sh file to be installed, but
>        it is not per default installed in the testenvironment
>        So allow tox tests to use "external" modules
> 
>     Signed-off-by: Willem Jan Withagen <wjw@digiware.nl>
> 
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
