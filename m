From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] skip loading keyrings when auth supported = none
Date: Wed, 8 Aug 2012 14:06:12 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208081405110.3347@cobra.newdream.net>
References: <871uk0pw8p.fsf@agnew.wgtn.ondioline.org> <87wr1qnlev.fsf@agnew.wgtn.ondioline.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48851 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001Ab2HHVGM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Aug 2012 17:06:12 -0400
In-Reply-To: <87wr1qnlev.fsf@agnew.wgtn.ondioline.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Paul Collins <paul.collins@canonical.com>
Cc: ceph-devel@vger.kernel.org

Hi Paul,

I pushed a different patch that fixes mkcephfs to use the correct default 
locations for keyrings.  The intended (and now, actual) behavior of 
mkcephfs is that it will generate and install keys regardless of whether 
cephx is enabled/required so that you can turn it on later.

This just hit the stable branch and will be in 0.48.1argonaut (a few days 
away).

Thanks!
sage


On Fri, 27 Jul 2012, Paul Collins wrote:

> If the cluster is not currently using authentication, then it's
> possible that no keyrings were ever created.  Proceed with monitor
> initialization regardless and explain what we did.
> 
> With this patch applied, my 0.48 monitor cluster starts up
> correctly even when no keyring files are present in the monitors'
> data directories.
> 
> Signed-off-by: Paul Collins <paul.collins@canonical.com>
> ---
>  src/mon/Monitor.cc |   40 ++++++++++++++++++++++------------------
>  1 file changed, 22 insertions(+), 18 deletions(-)
> 
> diff --git a/src/mon/Monitor.cc b/src/mon/Monitor.cc
> index c415dbf..bdd6a91 100644
> --- a/src/mon/Monitor.cc
> +++ b/src/mon/Monitor.cc
> @@ -322,22 +322,26 @@ int Monitor::init()
>      extract_save_mon_key(keyring);
>    }
>  
> -  ostringstream os;
> -  os << g_conf->mon_data << "/keyring";
> -  int r = keyring.load(cct, os.str());
> -  if (r < 0) {
> -    EntityName mon_name;
> -    mon_name.set_type(CEPH_ENTITY_TYPE_MON);
> -    EntityAuth mon_key;
> -    if (key_server.get_auth(mon_name, mon_key)) {
> -      dout(1) << "copying mon. key from old db to external keyring" << dendl;
> -      keyring.add(mon_name, mon_key);
> -      bufferlist bl;
> -      keyring.encode_plaintext(bl);
> -      store->put_bl_ss(bl, "keyring", NULL);
> -    } else {
> -      derr << "unable to load initial keyring " << g_conf->keyring << dendl;
> -      return r;
> +  if (auth_supported.is_supported_auth(CEPH_AUTH_NONE)) {
> +    dout(10) << "auth supported = none, no keys to load" << dendl;
> +  } else {
> +    ostringstream os;
> +    os << g_conf->mon_data << "/keyring";
> +    int r = keyring.load(cct, os.str());
> +    if (r < 0) {
> +      EntityName mon_name;
> +      mon_name.set_type(CEPH_ENTITY_TYPE_MON);
> +      EntityAuth mon_key;
> +      if (key_server.get_auth(mon_name, mon_key)) {
> +	dout(1) << "copying mon. key from old db to external keyring" << dendl;
> +	keyring.add(mon_name, mon_key);
> +	bufferlist bl;
> +	keyring.encode_plaintext(bl);
> +	store->put_bl_ss(bl, "keyring", NULL);
> +      } else {
> +	derr << "unable to load initial keyring " << g_conf->keyring << dendl;
> +	return r;
> +      }
>      }
>    }
>  
> @@ -346,8 +350,8 @@ int Monitor::init()
>  
>    // unlock while registering to avoid mon_lock -> admin socket lock dependency.
>    lock.Unlock();
> -  r = admin_socket->register_command("mon_status", admin_hook,
> -				     "show current monitor status");
> +  int r = admin_socket->register_command("mon_status", admin_hook,
> +					 "show current monitor status");
>    assert(r == 0);
>    r = admin_socket->register_command("quorum_status", admin_hook,
>  					 "show current quorum status");
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
