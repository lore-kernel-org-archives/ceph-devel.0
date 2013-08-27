From: Roald van Loon <roaldvanloon@gmail.com>
Subject: Re: [PATCH] cleanup: removed last references to g_conf from auth
Date: Tue, 27 Aug 2013 11:51:39 +0200
Message-ID: <CAN04cT5w+PrNAaigYeRGQftm6axzQf3SaD4jW+C9jrhwn1TxKw@mail.gmail.com>
References: <CAN04cT65Dd0q-VcKgmr56JrZkt9dKv3Qkv-1aKHtgUydrV10ow@mail.gmail.com>
	<1377596997-973-1-git-send-email-roaldvanloon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:58059 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245Ab3H0Jvk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Aug 2013 05:51:40 -0400
Received: by mail-ob0-f176.google.com with SMTP id uz19so4399462obc.21
        for <ceph-devel@vger.kernel.org>; Tue, 27 Aug 2013 02:51:39 -0700 (PDT)
In-Reply-To: <1377596997-973-1-git-send-email-roaldvanloon@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Sorry, the format-patch of the first email was screwed up (tried to
copy/paste the email because git was compiled without perl and hence
had no send-email support... should have known that would go haywire)

Roald

On Tue, Aug 27, 2013 at 11:49 AM, Roald J. van Loon
<roaldvanloon@gmail.com> wrote:
> Trivial cleanup. There were still 3 references to g_conf in CephxKeyServer.
> Replaced them in favor of cct->_conf.
>
> Signed-off-by: Roald J. van Loon <roaldvanloon@gmail.com>
> ---
>  src/auth/cephx/CephxKeyServer.cc | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/src/auth/cephx/CephxKeyServer.cc b/src/auth/cephx/CephxKeyServer.cc
> index e0c8174..e57b557 100644
> --- a/src/auth/cephx/CephxKeyServer.cc
> +++ b/src/auth/cephx/CephxKeyServer.cc
> @@ -163,7 +163,7 @@ bool KeyServer::_check_rotating_secrets()
>      ldout(cct, 10) << __func__ << " added " << added << dendl;
>      data.rotating_ver++;
>      //data.next_rotating_time = ceph_clock_now(cct);
> -    //data.next_rotating_time += MIN(g_conf->auth_mon_ticket_ttl, g_conf->auth_service_ticket_ttl);
> +    //data.next_rotating_time += MIN(cct->_conf->auth_mon_ticket_ttl, cct->_conf->auth_service_ticket_ttl);
>      _dump_rotating_secrets();
>      return true;
>    }
> @@ -191,7 +191,7 @@ int KeyServer::_rotate_secret(uint32_t service_id)
>    RotatingSecrets& r = data.rotating_secrets[service_id];
>    int added = 0;
>    utime_t now = ceph_clock_now(cct);
> -  double ttl = service_id == CEPH_ENTITY_TYPE_AUTH ? g_conf->auth_mon_ticket_ttl : g_conf->auth_service_ticket_ttl;
> +  double ttl = service_id == CEPH_ENTITY_TYPE_AUTH ? cct->_conf->auth_mon_ticket_ttl : cct->_conf->auth_service_ticket_ttl;
>
>    while (r.need_new_secrets(now)) {
>      ExpiringCryptoKey ek;
> @@ -424,7 +424,7 @@ int KeyServer::_build_session_auth_info(uint32_t service_id, CephXServiceTicketI
>  {
>    info.service_id = service_id;
>    info.ticket = auth_ticket_info.ticket;
> -  info.ticket.init_timestamps(ceph_clock_now(cct), g_conf->auth_service_ticket_ttl);
> +  info.ticket.init_timestamps(ceph_clock_now(cct), cct->_conf->auth_service_ticket_ttl);
>
>    generate_secret(info.session_key);
>
> --
> 1.7.12.4
>
