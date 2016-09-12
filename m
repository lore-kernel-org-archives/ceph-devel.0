From: Jesse Williamson <jwilliamson@suse.de>
Subject: Re: Encode/Decode new framework
Date: Mon, 12 Sep 2016 16:23:36 -0700 (PDT)
Message-ID: <alpine.LSU.2.20.1609121615460.2825@ancalagon.suse.de>
References: <BLUPR0201MB190892BDBE41A2AA7502EB9DE2F80@BLUPR0201MB1908.namprd02.prod.outlook.com> <alpine.DEB.2.11.1609072114580.32742@piezo.us.to> <alpine.DEB.2.11.1609081926450.10416@piezo.us.to> <CAN=+7FXp9nLT17Z6ve-OCMHLWS68rUB_5tPN03S-4oQcCjo0AQ@mail.gmail.com>
 <alpine.DEB.2.11.1609091957410.20211@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44880 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750839AbcILXXl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 12 Sep 2016 19:23:41 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9D1B5AB1A
        for <ceph-devel@vger.kernel.org>; Mon, 12 Sep 2016 23:23:39 +0000 (UTC)
In-Reply-To: <alpine.DEB.2.11.1609091957410.20211@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 9 Sep 2016, Sage Weil wrote:

> template<typename T, typename traits=denc_traits<T>>
> struct denc_traits<std::list<T>> {
>  enum { supported = traits::supported };

...not sure if this is quite you're after, but you might be able to 
accomplish something like that with template-using:

struct my_traits
{
  enum class supported { feature0, feature1 };
};

template <typename T, typename Traits>
struct denc_traits;

template <typename T, typename Traits>
struct denc_traits
{
  using supported = typename Traits::supported;
};

template <typename T>
using my_denc_traits = denc_traits<T, my_traits>;

int main()
{
  my_denc_traits<int> bletch;
}

Hope that helps,

-Jesse

