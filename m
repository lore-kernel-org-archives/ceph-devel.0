From: Milosz Tanski <milosz@adfin.com>
Subject: Re: [PATCH 2/5] new fscache interface to check cache consistency
Date: Wed, 4 Sep 2013 12:48:44 -0400
Message-ID: <CANP1eJFKGD_h6rcWMWpxp3yOD+rz6p2P0B+2CTcy1taDwM9rdg@mail.gmail.com>
References: <cover.1375999914.git.milosz@adfin.com>
	<306cbe63f85921ad40b00e3c7071be19cb6adf04.1375999914.git.milosz@adfin.com>
	<18832.1378311843@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <18832.1378311843@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Hongyi Jia <jiayisuse@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>, "Yan, Zheng" <zheng.z.yan@intel.com>, "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

David,

If the cache is withdrawn and we're starting anew I would consider
that to okay. I would consider an empty page cache for a cookie to be
consistent since there's nothing stale that I can read. Unless there's
another synchronization issue that I'm missing in fscache.

Thanks,
- Milosz

On Wed, Sep 4, 2013 at 12:24 PM, David Howells <dhowells@redhat.com> wrote:
> Hongyi Jia <jiayisuse@gmail.com> wrote:
>
>> +bool __fscache_check_consistency(struct fscache_cookie *cookie)
>> +{
>> +     struct fscache_object *object;
>> +
>> +     if (cookie->def->type != FSCACHE_COOKIE_TYPE_DATAFILE)
>> +             return false;
>> +
>> +     if (hlist_empty(&cookie->backing_objects))
>> +             return false;
>> +
>> +     object = hlist_entry(cookie->backing_objects.first,
>> +                     struct fscache_object, cookie_link);
>> +
>> +     return object->cache->ops->check_consistency(object);
>> +}
>
> Hmmm...  This isn't actually safe.  You have to either:
>
>  (1) hold cookie->lock whilst touching the object pointer when coming from the
>      netfs side, or:
>
>  (2) set up an operation to do this (as, say, __fscache_alloc_page() does).
>
> The problem is that you have nothing to defend against the object being
> withdrawn by the cache under you.
>
> David
