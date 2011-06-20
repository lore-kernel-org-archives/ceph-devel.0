From: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Subject: Re: metablob fix
Date: Mon, 20 Jun 2011 10:40:49 -0700
Message-ID: <BANLkTimox5NBpELSFiSOF007Qs_m_DeR9Q@mail.gmail.com>
References: <Pine.LNX.4.64.1106172215440.4755@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47389 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755841Ab1FTRku convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Jun 2011 13:40:50 -0400
Received: by fxm17 with SMTP id 17so1123407fxm.19
        for <ceph-devel@vger.kernel.org>; Mon, 20 Jun 2011 10:40:49 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1106172215440.4755@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: samlang@gmail.com, ceph-devel@vger.kernel.org

On Fri, Jun 17, 2011 at 10:17 PM, Sage Weil <sage@newdream.net> wrote:
> Hi Sam-
>
> I pushed a fix for the valgrind error you were seeing to mds_metablob=
_fix.
> There was a class used in an STL container that wasn't copyable. =A0A=
s far
> as I can tell, you can't actually put items in a container (map<> in =
this
> case) that aren't copyable, so I used a boost::smart_ptr.
>
> Maybe someone with better C++-fu than I has a way to avoid the copies
> entirely? =A0Adding
>
> =A0 =A0 =A0 =A0fullbit(const fullbit& other);
> =A0 =A0 =A0 =A0const fullbit operator=3D(const fullbit& other);
>
> fails to link, and if I assert in there I can't get past inserting th=
e
> initial element. =A0:/

I'm afraid not. You can't put something into an STL container unless
it has a working copy constructor.

By using std::insert instead of operator[], you avoid the need for a
default constructor, but you can't avoid the copy.

By the way, tr1::shared_ptr is the shiny new, standardized version of
boost::smart_ptr.

cheers,
Colin
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
