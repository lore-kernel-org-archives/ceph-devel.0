From: Mykola Golub <to.my.trociny@gmail.com>
Subject: Re: Fwd: Build failed in Jenkins: ceph-master #94
Date: Mon, 19 Dec 2016 09:02:43 +0200
Message-ID: <20161219070242.GA1543@gmail.com>
References: <2025831951.53.1481945498160.JavaMail.jenkins@cephdev.digiware.nl>
 <93c0f8ac-a1e1-eaed-19bc-1be68b31f06f@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:33663 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751257AbcLSHCr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Dec 2016 02:02:47 -0500
Received: by mail-lf0-f48.google.com with SMTP id c13so47652876lfg.0
        for <ceph-devel@vger.kernel.org>; Sun, 18 Dec 2016 23:02:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <93c0f8ac-a1e1-eaed-19bc-1be68b31f06f@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Jason Dillaman <jdillama@redhat.com>

This is due to the recently added config option validators [1] (aimed
to solve the API issue with rbd_default_features option).

It uses std::is_constructible to check if a type exists or just
forward declared. Apparently, it does not work for clang. Using
std::is_destructible instead looks like work [2].

[1] https://github.com/ceph/ceph/pull/12486
[2] https://github.com/trociny/ceph/commit/bd584fe797e30d666800cd4d9b440d4b51d1d27e

On Sat, Dec 17, 2016 at 01:34:48PM +0100, Willem Jan Withagen wrote:
> Hi,
> 
> My FreeBSD builder starts to complain during compilation about
> the error repeated below.
> 
> 
> --WjW
> 
> n file included from
> /home/jenkins/workspace/ceph-master/src/common/config.cc:15:
> In file included from
> /home/jenkins/workspace/ceph-master/src/auth/Auth.h:18:
> In file included from
> /home/jenkins/workspace/ceph-master/src/auth/Crypto.h:18:
> In file included from
> /home/jenkins/workspace/ceph-master/src/include/types.h:21:
> In file included from
> /home/jenkins/workspace/ceph-master/src/include/uuid.h:8:
> In file included from
> /home/jenkins/workspace/ceph-master/src/include/encoding.h:19:
> In file included from
> /home/jenkins/workspace/ceph-master/src/include/rados/memory.h:4:
> In file included from /usr/include/c++/v1/memory:599:
> /usr/include/c++/v1/type_traits:2857:38: error: incomplete type
> 'md_config_t::option_host_t' used in type trait expression
>     : public integral_constant<bool, __is_constructible(_Tp, _Args...)>
>                                      ^
> /home/jenkins/workspace/ceph-master/src/common/config.cc:110:31: note:
> in instantiation of template class
> 'std::__1::is_constructible<md_config_t::option_host_t>' requested here
> typename std::enable_if<!std::is_constructible<T>::value,
>                               ^
> /home/jenkins/workspace/ceph-master/src/common/config_opts.h:16:1: note:
> while substituting explicitly-specified template arguments into function
> template 'create_validator'
> OPTION(host, OPT_STR, "localhost")
> ^
> /home/jenkins/workspace/ceph-master/src/common/config.cc:168:37: note:
> expanded from macro 'OPTION'
> #define OPTION(name, type, def_val) OPTION4(name, type, def_val, false)
>                                     ^
> /home/jenkins/workspace/ceph-master/src/common/config.cc:167:24: note:
> expanded from macro 'OPTION4'
>                        create_validator<option_##name##_t>() },
>                        ^
> /home/jenkins/workspace/ceph-master/src/common/config_opts.h:16:1: note:
> forward declaration of 'md_config_t::option_host_t'
> OPTION(host, OPT_STR, "localhost")
> ^
> /home/jenkins/workspace/ceph-master/src/common/config.h:321:12: note:
> expanded from macro 'OPTION'
>     struct option_##name##_t;
>            ^
> <scratch space>:51:1: note: expanded from here
> option_host_t
> ^
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Mykola Golub
