From: Roman Alekseev <rs.alekseev@gmail.com>
Subject: Re: rbd image association
Date: Mon, 03 Jun 2013 11:45:04 +0400
Message-ID: <51AC4980.4010000@gmail.com>
References: <51AC3D1E.2000800@gmail.com> <20130603070836.GA2422@nix.wogri.at> <51AC42FC.1040703@gmail.com> <51AC4717.7010304@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:58268 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981Ab3FCHpI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Jun 2013 03:45:08 -0400
Received: by mail-lb0-f177.google.com with SMTP id y6so404838lbh.22
        for <ceph-devel@vger.kernel.org>; Mon, 03 Jun 2013 00:45:06 -0700 (PDT)
In-Reply-To: <51AC4717.7010304@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Wolfgang Hennerbichler <wolfgang.hennerbichler@risc-software.at>, ceph-devel@vger.kernel.org

On 03.06.2013 11:34, Wido den Hollander wrote:
> udev takes car

Do you mean we need to create some rules in /etc/udev/rules.d/ directory 
and after running rbd -p pool map image my image will be mapped with 
appropriate device?

If so, could you please provide me with the commands which should be 
presented in that file?

Thanks

-- 
Kind regards,

R. Alekseev

