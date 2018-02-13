From: Volker Lendecke <Volker.Lendecke@SerNet.DE>
Subject: Re: [RFC PATCH] Samba RADOS service registration
Date: Tue, 13 Feb 2018 13:48:38 +0100
Message-ID: <20180213124838.y2jmrppzpjgsdagb@sernet.de>
References: <20180213022540.5f9686b7@suse.de>
 <CALe9h7dPuDOtY06RPXJ2u5wkT=j8S6D1PkwgfByuQ8y3cuP9Fg@mail.gmail.com>
 <20180213132941.0208a8b2@suse.de>
Reply-To: Volker.Lendecke@SerNet.DE
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.sernet.de ([185.199.217.2]:54370 "EHLO mail.SerNet.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935174AbeBMNSF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:18:05 -0500
Content-Disposition: inline
In-Reply-To: <20180213132941.0208a8b2@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: ceph-devel@vger.kernel.org, Samba Technical <samba-technical@lists.samba.org>

On Tue, Feb 13, 2018 at 01:29:41PM +0100, David Disseldorp via samba-technical wrote:
> > In the case of nfs-ganesha, we're moving toward having the option of
> > consuming its share configuration from a central place like a RADOS
> > object, rather than from a local text config file -- in that model, a
> > UI can go look at the configuration directly rather than having the
> > daemon report it back.  This is kind of a Ceph-ized version of the way
> > a lot of new projects are storing their configuration in etcd.
> 
> Interesting. The same should be possible for Samba when we eventually
> have a Ceph key-value store backend for Samba's dbwrap, and then use
> Registry configuration.

Is there API docs around for this key-value store?

Thanks,

Volker

-- 
Besuchen Sie die verinice.XP 2018 in Berlin,
Anwenderkonferenz für Informationssicherheit
vom 21.-23.03.2018 im Sofitel Kurfürstendamm
Info & Anmeldung hier: http://veriniceXP.org

SerNet GmbH, Bahnhofsallee 1b, 37081 Göttingen
phone: +49-551-370000-0, fax: +49-551-370000-9
AG Göttingen, HRB 2816, GF: Dr. Johannes Loxen
http://www.sernet.de, mailto:kontakt@sernet.de
