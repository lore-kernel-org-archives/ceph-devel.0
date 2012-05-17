From: Tommi Virtanen <tv@inktank.com>
Subject: Re: [PATCH 1/2 v2] rbd: allow importing from stdin
Date: Wed, 16 May 2012 17:00:15 -0700
Message-ID: <CADvuQREhvHmXRmAhuAez2fG3AqOqEdPWVDbTSXZgZu7ERQCiUw@mail.gmail.com>
References: <20120516203233.GA32219@sir.fritz.box> <CAC-hyiGsyMU5TogJ7SA8tQDVFY4Z5ht_hTwFB9dTsZgihBZJWw@mail.gmail.com>
 <CADvuQRH9KYM1KswDTBKsuMPKxqMdH0CBM=sGZq3BfMvWAG7sDQ@mail.gmail.com> <4FB43F43.2080205@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54731 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760743Ab2EQAAg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 May 2012 20:00:36 -0400
Received: by pbbrp8 with SMTP id rp8so1766141pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 16 May 2012 17:00:36 -0700 (PDT)
In-Reply-To: <4FB43F43.2080205@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, Christian Brunner <chb@muc.de>, ceph-devel@vger.kernel.org

On Wed, May 16, 2012 at 4:58 PM, Josh Durgin <josh.durgin@inktank.com> wrote:
> librbd prevents you from writing beyond the bounds of an image.
> If we keep that restriction, you'd need to resize the image to
> have enough space for the import, and resize down to the final
> size at the end.

That's actually good, so it doesn't leak objects.

The import could allocate in nicely sized chunks, and size down at the end.
