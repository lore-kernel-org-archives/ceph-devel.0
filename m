From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] cleanup: removed last references to g_conf from auth
Date: Tue, 27 Aug 2013 08:19:40 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308270819060.2000@cobra.newdream.net>
References: <CAN04cT65Dd0q-VcKgmr56JrZkt9dKv3Qkv-1aKHtgUydrV10ow@mail.gmail.com> <1377596997-973-1-git-send-email-roaldvanloon@gmail.com> <CAN04cT5w+PrNAaigYeRGQftm6axzQf3SaD4jW+C9jrhwn1TxKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49811 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378Ab3H0PTk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Aug 2013 11:19:40 -0400
In-Reply-To: <CAN04cT5w+PrNAaigYeRGQftm6axzQf3SaD4jW+C9jrhwn1TxKw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roald van Loon <roaldvanloon@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 27 Aug 2013, Roald van Loon wrote:
> Sorry, the format-patch of the first email was screwed up (tried to
> copy/paste the email because git was compiled without perl and hence
> had no send-email support... should have known that would go haywire)

Ha, no problem.  Applied now, thanks!

sage

> 
> Roald
> 
> On Tue, Aug 27, 2013 at 11:49 AM, Roald J. van Loon
> <roaldvanloon@gmail.com> wrote:
> > Trivial cleanup. There were still 3 references to g_conf in CephxKeyServer.
> > Replaced them in favor of cct->_conf.
> >
> > Signed-off-by: Roald J. van Loon <roaldvanloon@gmail.com>
> > ---
> >  src/auth/cephx/CephxKeyServer.cc | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/src/auth/cephx/CephxKeyServer.cc b/src/auth/cephx/CephxKeyServer.cc
> > index e0c8174..e57b557 100644
> > --- a/src/auth/cephx/CephxKeyServer.cc
> > +++ b/src/auth/cephx/CephxKeyServer.cc
> > @@ -163,7 +163,7 @@ bool KeyServer::_check_rotating_secrets()
> >      ldout(cct, 10) << __func__ << " added " << added << dendl;
> >      data.rotating_ver++;
> >      //data.next_rotating_time = ceph_clock_now(cct);
> > -    //data.next_rotating_time += MIN(g_conf->auth_mon_ticket_ttl, g_conf->auth_service_ticket_ttl);
> > +    //data.next_rotating_time += MIN(cct->_conf->auth_mon_ticket_ttl, cct->_conf->auth_service_ticket_ttl);
> >      _dump_rotating_secrets();
> >      return true;
> >    }
> > @@ -191,7 +191,7 @@ int KeyServer::_rotate_secret(uint32_t service_id)
> >    RotatingSecrets& r = data.rotating_secrets[service_id];
> >    int added = 0;
> >    utime_t now = ceph_clock_now(cct);
> > -  double ttl = service_id == CEPH_ENTITY_TYPE_AUTH ? g_conf->auth_mon_ticket_ttl : g_conf->auth_service_ticket_ttl;
> > +  double ttl = service_id == CEPH_ENTITY_TYPE_AUTH ? cct->_conf->auth_mon_ticket_ttl : cct->_conf->auth_service_ticket_ttl;
> >
> >    while (r.need_new_secrets(now)) {
> >      ExpiringCryptoKey ek;
> > @@ -424,7 +424,7 @@ int KeyServer::_build_session_auth_info(uint32_t service_id, CephXServiceTicketI
> >  {
> >    info.service_id = service_id;
> >    info.ticket = auth_ticket_info.ticket;
> > -  info.ticket.init_timestamps(ceph_clock_now(cct), g_conf->auth_service_ticket_ttl);
> > +  info.ticket.init_timestamps(ceph_clock_now(cct), cct->_conf->auth_service_ticket_ttl);
> >
> >    generate_secret(info.session_key);
> >
> > --
> > 1.7.12.4
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
