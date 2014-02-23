From: Noah Watkins <noah.watkins@inktank.com>
Subject: Re: doxygen help
Date: Sun, 23 Feb 2014 13:44:17 -0800
Message-ID: <CA+Hcz59aqHEeL3-_bdpKduRuqE+JgWadMOQRbkPF2tf5w+SEWw@mail.gmail.com>
References: <alpine.DEB.2.00.1402231235060.17508@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:64601 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544AbaBWVoV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 23 Feb 2014 16:44:21 -0500
Received: by mail-qa0-f47.google.com with SMTP id j5so5538916qaq.34
        for <ceph-devel@vger.kernel.org>; Sun, 23 Feb 2014 13:44:18 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1402231235060.17508@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I don't think Asphyxiate handles 'class'

  http://marc.info/?l=ceph-devel&m=135130277326664&w=2

On Sun, Feb 23, 2014 at 12:38 PM, Sage Weil <sage@inktank.com> wrote:
> A while back I added some doxygen comments/docs to librados.hpp and tried
> to have sphinx slurp it up into the generated docs on ceph.com:
>
>         https://github.com/ceph/ceph/commit/d0c4600e6645d116b9b2c4eea56ef5851eea54d5
>
> Unfortunately this flames out with some obscure doxygen error and I wasn't
> able to sort it out given my limited attention span and experience with
> such tools.  You can see the error here:
>
>         http://gitbuilder.sepia.ceph.com/gitbuilder-doc/log.cgi?log=d0c4600e6645d116b9b2c4eea56ef5851eea54d5
>
> Exception occurred:
> File "/tmp/virtualenv-docs/src/asphyxiate/asphyxiate/__init__.py", line
> 388, in render_compounddef
> "cannot handle {node.tag} kind={node.attrib[kind]}".format(node=node)
> Error: Assertion cannot handle compounddef kind=class
>
> Anybody know what might be going on?  This is the main thing preventing
> the C++ librados API docs (such as they are) from appearing on the site.
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
