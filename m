From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: Metadata queries on Ceph/RADOS
Date: Tue, 22 Nov 2011 09:09:25 -0800
Message-ID: <4ECBD745.1060708@dreamhost.com>
References: <CAMiHsJJN1UB++ijcorzBBi=YD9eawur62WF9L1QxtwwiH78HXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:58751 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965Ab1KVRJ0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Nov 2011 12:09:26 -0500
In-Reply-To: <CAMiHsJJN1UB++ijcorzBBi=YD9eawur62WF9L1QxtwwiH78HXw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Atish Kathpal <atish.kathpal@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 11/22/2011 12:11 AM, Atish Kathpal wrote:
> Hello
>
> Does RADOS support metadata queries? I have gone through librados and
> the "rados" command line tool, and there doesn't seem to be a way for
> me to say, query the object store saying: "Give me all objects with
> Xattr Video = 1". The only way I can think of is to write some of my
> own code using librados.

That's right, RADOS operates on a single-object transaction level. 
There's no way for it to support consistent reads of multiple objects 
without rewriting much of the OSD - it's not designed for that. For your 
use case, you could store your metadata in a trivial map (tmap) object 
using librados' tmap_* functions. This is what radosgw uses for storing 
which objects are in which buckets. These are slow for large mappings, 
but we have plans to fix that  (http://tracker.newdream.net/issues/1571).

> Any pointers if the system has a metadata service or something that I
> can query?
>
> (I have seen few diagrams showing a metadata cluster as part of Ceph
> which supports metadata operations, how can I leverage that? reference
> diagram: http://www.usenix.org/event/osdi06/tech/full_papers/weil/weil_html/fig/overview.png)

The metadata cluster is for the Ceph distruted file system, which is 
another layer on top of RADOS.
