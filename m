From: Dave Holland <dh3@sanger.ac.uk>
Subject: radosgw refuses upload when Content-Type missing from POST policy
 (fwd)
Date: Fri, 2 Jun 2017 10:09:39 +0100
Message-ID: <20170602090939.GJ2558@sanger.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.sanger.ac.uk ([193.62.202.243]:31090 "EHLO
        smtp.sanger.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750813AbdFBJU7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Jun 2017 05:20:59 -0400
Received: from maybe.internal.sanger.ac.uk ([172.30.17.111])
        by intmail3b.internal.sanger.ac.uk with esmtp (Exim 4.80.1)
        (envelope-from <dh3@sanger.ac.uk>)
        id 1dGiaR-000FAM-Sa
        for ceph-devel@vger.kernel.org; Fri, 02 Jun 2017 10:09:39 +0100
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Resending to ceph-devel, as I guess when radosgw behaves differently to
AWS S3 it's more an interoperability question than a usage question.

Cheers,
Dave

----- Forwarded message from Dave Holland <dh3@sanger.ac.uk> -----

Date: Wed, 31 May 2017 17:02:14 +0100
From: Dave Holland <dh3@sanger.ac.uk>
To: ceph-users@lists.ceph.com
Subject: radosgw refuses upload when Content-Type missing from POST policy
Message-ID: <20170531160214.GC2558@sanger.ac.uk>

Hi,

I'm trying to get files into radosgw (Ubuntu Ceph package
10.2.3-0ubuntu0.16.04.2) using Fine Uploader
https://github.com/FineUploader/fine-uploader but I'm running into
difficulties in the case where the uploaded file has a filename
extension which the browser can't map to a MIME type (or, no extension
at all).

The radosgw replies with a 403 error, "Policy missing condition:
Content-Type". Examining the policy which the browser sends as part of
the multipart data confirms that there is no Content-Type. (The POST and
multipart do have Content-Type headers.) The same code and POST works
fine against AWS S3. Should radosgw require a Content-Type in the POST
policy when AWS S3 doesn't? It seems that for maximum compatibility, it
shouldn't.

The bucket's CORS policy is "<AllowedHeader>*</AllowedHeader>" but it
doesn't work with explicitly mentioning Content-Type either.

I put a radosgw debug=20 log of the successful OPTIONS call and failing
POST call here:
https://docs.google.com/document/d/1i3exJSil1xj14ZrDOF_oM9eZC238gnNVAsnaZ-Pkvzo/edit?usp=sharing

Happy to provide other debug info if necessary.

thanks,
Dave
-- 
** Dave Holland ** Systems Support -- Informatics Systems Group **
** 01223 496923 ** The Sanger Institute, Hinxton, Cambridge, UK **

----- End forwarded message -----



-- 
 The Wellcome Trust Sanger Institute is operated by Genome Research 
 Limited, a charity registered in England with number 1021457 and a 
 company registered in England with number 2742969, whose registered 
 office is 215 Euston Road, London, NW1 2BE. 
