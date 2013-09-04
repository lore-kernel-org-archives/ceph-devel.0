From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 2/5] new fscache interface to check
	cache consistency
Date: Wed, 04 Sep 2013 17:24:03 +0100
Message-ID: <18832.1378311843@warthog.procyon.org.uk>
References: <306cbe63f85921ad40b00e3c7071be19cb6adf04.1375999914.git.milosz@adfin.com>
	<cover.1375999914.git.milosz@adfin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-cachefs-bounces@redhat.com>
In-Reply-To: <306cbe63f85921ad40b00e3c7071be19cb6adf04.1375999914.git.milosz@adfin.com>
List-Unsubscribe: <https://www.redhat.com/mailman/options/linux-cachefs>,
	<mailto:linux-cachefs-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/linux-cachefs>
List-Post: <mailto:linux-cachefs@redhat.com>
List-Help: <mailto:linux-cachefs-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/linux-cachefs>,
	<mailto:linux-cachefs-request@redhat.com?subject=subscribe>
Sender: linux-cachefs-bounces@redhat.com
Errors-To: linux-cachefs-bounces@redhat.com
To: Hongyi Jia <jiayisuse@gmail.com>, milosz@adfin.com
Cc: sage@inktank.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com, zheng.z.yan@intel.com, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hongyi Jia <jiayisuse@gmail.com> wrote:

> +bool __fscache_check_consistency(struct fscache_cookie *cookie)
> +{
> +	struct fscache_object *object;
> +
> +	if (cookie->def->type != FSCACHE_COOKIE_TYPE_DATAFILE)
> +		return false;
> +
> +	if (hlist_empty(&cookie->backing_objects))
> +		return false;
> +
> +	object = hlist_entry(cookie->backing_objects.first,
> +			struct fscache_object, cookie_link);
> +
> +	return object->cache->ops->check_consistency(object);
> +}

Hmmm...  This isn't actually safe.  You have to either:

 (1) hold cookie->lock whilst touching the object pointer when coming from the
     netfs side, or:

 (2) set up an operation to do this (as, say, __fscache_alloc_page() does).

The problem is that you have nothing to defend against the object being
withdrawn by the cache under you.

David
