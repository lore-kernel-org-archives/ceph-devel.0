From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: Crush not deliverying data uniformly -> HEALTH_ERR full osd
Date: Mon, 6 Aug 2012 13:55:01 +0200
Message-ID: <CAF6-1L5fYgw5s25oPPFVi+OTF95wb33RfAwqYPT1iN7cXT7LzQ@mail.gmail.com>
References: <81C477727102DA4E9B2605AC748C495419104F5549@exch10>
	<CAC-hyiG54FgJmhHibkY6a-qqePALEjGrWrxNwHo2KhehswLfpw@mail.gmail.com>
	<81C477727102DA4E9B2605AC748C495419104F5553@exch10>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:62754 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756006Ab2HFLzB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Aug 2012 07:55:01 -0400
Received: by vcbfk26 with SMTP id fk26so2510471vcb.19
        for <ceph-devel@vger.kernel.org>; Mon, 06 Aug 2012 04:55:01 -0700 (PDT)
In-Reply-To: <81C477727102DA4E9B2605AC748C495419104F5553@exch10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Paul Pettigrew <Paul.Pettigrew@mach.com.au>
Cc: Yehuda Sadeh <yehuda@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Out of curiosity is it the data that's not properly distributed inside
the placement groups or are the placement groups not distributed among
the OSDs ?

Can you can provide a full 'ceph pg dump' ? (as a text attachement or
something).

Cheers,

    Sylvain
