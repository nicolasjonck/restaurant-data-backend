SELECT distinct dim_category_translated as original_category,
  CASE
    WHEN REGEXP_CONTAINS(LOWER(dim_category_translated), r'tea|coffee|hot drinks|soft|soda and fruit juices|cold drinks|drinks lunch|cafe|cafeteria|bar|hot drinks|bar|cold drinks|room|hot drinks|room|cold drinks|drinks ☕️|our hot drinks|water|hot|san pellegrino|juice|delamotte|the closed|ae other beverages|fruit juice|e-bike drinks|juice and nectar zenat|evian|drinks|petillants|drinks rest|expressions espresso|the little +|indian drinks|roiboos ice bos|snap|lassi 40 cl|petillant nature|fresh beverages|☕️|drinks|cafés|lassi|the') THEN 'Non-Alcoholic Drinks'
    WHEN REGEXP_CONTAINS(LOWER(dim_category_translated), r'beer|pressure|sall|bieres|mills|cocktail|alcoholic beverage|alcohol|happy hour|spirits|liquor|alcohols \(4cl\)|alcohol sup|alcohol room|strong alcohols|drinks without alcohol|mineral water|our mineral waters|martini|whiskeys|martini 15 cl|digestive|did 15 cl|digestives 2 cl|aperitifs|aperitif|whisky 5 cl|we aperitifs|digestives|martini|long drink|bar|aperitif|wine|rosé|white bottle|pink glass|white glass|red bottle|red glass|wine white/rosé|wine menu|wine glass and carafe|wine d-wine|wines glasses|wines & champagnes|wine by the glass|champagne|superior bordeaux goélane|tasting of 3 crus|cotes du rhone|alsace riesling|south map|igp côtes du tarn|appie cider|vins bt|laurent-perrier|cider|bourgueil le plessis|muscadet sur lie|coasts of provence|golden valley|alsace pinot noir|nos champagnes|cave|vins 37.5cl|valpolicella|bottle pink|bar|vin|tasting|visit|buzet merlot|tuscan|bordeaux red pdo|champagne |džgustation de 3 crus|anjou chen\'s|aperitif|sicily|champagne|grover\'s rouge|touraine gamay') THEN 'Alcoholic Drinks'
    WHEN REGEXP_CONTAINS(LOWER(dim_category_translated), r'evening|evening menu|dinner|night|evening menu|new year\'s eve|valentine\'s day|easter|low cost evening|private party|children\'s menu|menu 25,00|menus|menu|choice of formula|menu|valentine\'s day|formula|cookings|coursemeal|flat formula|menu 16,50|new year\'s eve|tasting menu|every twenty of the month|new year\'s eve menu|lunch formula|menu midi|lunch|menu express|formulas of the day|main course formula|lunch|formation|formulas|discovery menu|midi|breakfast|midi card|today\'s special|breakfast 8:30 a.m.|11:30 a.m.') THEN 'Menu'
    WHEN REGEXP_CONTAINS(LOWER(dim_category_translated), r'appetizers|starter|entree|starters|appetizers|soups|salads|entrees emp|in-salads to go|brunch|room|aperitif|ae moccamaster drip|vae soup &amp; broth|to start|plank|soup|boards|tibetan entry|plank|entry formula|boards') THEN 'Appetizer'
    WHEN REGEXP_CONTAINS(LOWER(dim_category_translated), r'main course|dishes of the day|meat|fish|pizza|pasta|take-out|delivery|dine in|takeaway|tandoori|grilled|fried|eating is cheating|sides|supplements|options|dish|main|dishes|bowl|spokebowl|seasonal bowls|weekly bowl|north vegetarian choice|rice|mix grill|lamb smile|cooking|hot meals|plat|vegan|avocado toast|ae in frozen version|buckwheat wrap|you love us|accompaniments|salads|castle of the mountain|in-salads on site|snacks|frawmages|southern vegetarian choice|charcuterie|cheese|meal|salads|royal biryani|brouilly|syrup|pains|focaccia sur place|snacks sucres|soup &amp; broth|to take with|soup and ramen|send out|plats vae|selection 125g|meal jars|tapas|other hot specialties|accompaniments|breizh\'n\'roll|e-bike sandwiches|vegetarian choice north 1|pain|place vegetarian|sandwiches|vegetables|sandwiches|cooking|supplement|southern vegetarian choice 1|selection 1kg|condiments|biriyani|salty desires|other cup specialties|vae salads|selection 250g') THEN 'Main Dish'
    WHEN REGEXP_CONTAINS(LOWER(dim_category_translated), r'dessert|sweets|desserts on site|desserts to take|house desserts|sweet tooth|rooibos glace bos|ice creams and sorbets|ice ice baby|sugar|ei sugars|chocolate plate|ice taste|pastries|sugars|ice cream flavors|fragrances sorbets|sorbets|ice cream|coulis perfumes|panna cotta') THEN 'Dessert'
    ELSE 'Other'
  END AS consolidated_category
FROM {{ source ('restaurant_raw_data','order_details') }}
