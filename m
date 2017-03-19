From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: why do we delete target in RGWGetObjLayout constructed
 function?
Date: Sun, 19 Mar 2017 19:03:11 -0400 (EDT)
Message-ID: <1973705770.3254367.1489964591721.JavaMail.zimbra@redhat.com>
References: <CACKY0b_snoqrOhhXGFjZmypYx+zByyxNihjahRJQBtse3_Aw3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37000 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752335AbdCSXLd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 19 Mar 2017 19:11:33 -0400
In-Reply-To: <CACKY0b_snoqrOhhXGFjZmypYx+zByyxNihjahRJQBtse3_Aw3A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: liuchang0812 <liuchang0812@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

Something looks funny, I'd agree.  However, for posterity, it's legal and therefore safe to delete (and free) nullptr.

Matt

----- Original Message -----
> From: "liuchang0812" <liuchang0812@gmail.com>
> To: "ceph-devel" <ceph-devel@vger.kernel.org>
> Sent: Friday, March 17, 2017 5:58:14 AM
> Subject: why do we delete target in RGWGetObjLayout constructed function?
> 
> I saw this problem when i read RGW source code. It seems that that
> `delete` a nullptr will segment fault.
> 
> code[1]:
> 
> class RGWGetObjLayout : public RGWOp {
>    protected:
>         RGWRados::Object *target{nullptr};
>         RGWObjManifest *manifest{nullptr};
>         rgw_raw_obj head_obj;
>     public:
>          RGWGetObjLayout() {
>              delete target;
>    }
> 
> 
> [1]. https://github.com/ceph/ceph/blob/master/src/rgw/rgw_op.h#L1777
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-821-5101
fax.  734-769-8938
cel.  734-216-5309
