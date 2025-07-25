using System.IO;
using UnityEngine;
using FlatTables;

namespace FlatTables.Sample
{
    public class ClientSample : MonoBehaviour
    {
        // Use this for initialization
        void Start()
        {
            ConfManager.SetConfFileLoader(new ConfFileLoader(), false);

            // The example obtains all the hero data
            var count = ConfHero.Instance.Count;
            for (var i = 0; i < count; i++)
            {
                var heroInfo = ConfHero.Instance.GetByIndex(i);
                if (heroInfo.HasValue)
                {
                    Debug.Log($"Hero: {heroInfo.Value.Id}, {heroInfo.Value.Name}");
                }
            }

            // The example retrieves the specified guide data and accesses the referenced external table fields
            var guideInfo = ConfGuide.Instance.Get("id_guide_1");
            if (guideInfo.HasValue)
            {
                Debug.Log($"Guide: {guideInfo.Value.Type}, {guideInfo.Value.FinishRewardRef}");
            }

            ConfManager.DisposeAll();
        }
    }

    public class ConfFileLoader : IConfFileLoader
    {
        public byte[] LoadAllBytes(string fileName)
        {
            var resourceName = Path.GetFileNameWithoutExtension(fileName);
            var textAsset = Resources.Load<TextAsset>(resourceName);
            return textAsset != null ? textAsset.bytes : null;
        }
    }
}
