From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: RadosGW crashing on copy for one specific object
Date: Mon, 25 Aug 2014 11:00:46 +0200
Message-ID: <CAF6-1L60V1HzCKv1FR_honU5QxYBVZx6gb9AUQrOL+H-N7wwSw@mail.gmail.com>
References: <CAF6-1L4zXmczyvXyD=1ZKjO67BYDoPMa3JEaKn082y5WUZY39w@mail.gmail.com>
	<CABBk=J8qLc45ggoqdWEZVi3YF0Og9wuj_5tW_5Gng+bh65rUjg@mail.gmail.com>
	<CAF6-1L6GWKmncQXA_e4NzaFzLqefzQ4O1qikW0zG6k7BrrMvHg@mail.gmail.com>
	<CABBk=J8G=fWC5_m0qxAaYAH0UioYA++87S84J9+23B2BxNs39g@mail.gmail.com>
	<CABBk=J851yHsd05Lk7JzBk0jDFAM8HRKC0Yz7XmntrpFkCZh=Q@mail.gmail.com>
	<CABBk=J8B-Ph_Ju7uHOuXydXdSXw1tL4v1dvPvy7P=A19XtTTTQ@mail.gmail.com>
	<CAF6-1L7hSYHoNeKUCu466UHUVbVUAQ6mWzK3V9B6TTuqMkpRLA@mail.gmail.com>
	<CABBk=J8S_fkBMORDy9RbYLh6HWi+-EzyZefBNPmnBRWNuPOHAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:62520 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbaHYJAu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Aug 2014 05:00:50 -0400
Received: by mail-pd0-f180.google.com with SMTP id v10so19834543pde.11
        for <ceph-devel@vger.kernel.org>; Mon, 25 Aug 2014 02:00:46 -0700 (PDT)
In-Reply-To: <CABBk=J8S_fkBMORDy9RbYLh6HWi+-EzyZefBNPmnBRWNuPOHAg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Yehuda,


> diff --git a/src/rgw/rgw_rados.h b/src/rgw/rgw_rados.h
> index ed8f02d..0042df2 100644
> --- a/src/rgw/rgw_rados.h
> +++ b/src/rgw/rgw_rados.h
> @@ -306,6 +306,11 @@ public:
>
>    bool has_tail() {
>      if (explicit_objs) {
> +      if (objs.size() == 1) {
> +        map<uint64_t, RGWObjManifestPart>::iterator iter = objs.begin();
> +        rgw_obj& obj = iter->second.loc;
> +        return head_obj.object != obj.object;
> +      }
>        return (objs.size() >= 2);
>      }
>      return (obj_size > head_size);
>

I confirm that this fixes the issue.

I was able to copy the key and read the resulting copied key.


Cheers,

     Sylvain
